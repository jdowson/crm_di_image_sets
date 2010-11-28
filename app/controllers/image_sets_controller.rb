
class ImageSetsController < ApplicationController

  before_filter :require_user
  before_filter :auto_complete, :only => :auto_complete
  before_filter :update_sidebar, :only => :index
  before_filter :set_current_tab, :only => [ :index, :show ]

  # GET /image_sets
  # GET /image_sets.xml
  #----------------------------------------------------------------------------
  def index
    @image_sets = ImageSet.all

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @image_sets.inject({}) { |image_sets, (k,v)| image_sets[k.to_s] = v; image_sets } }
    end
  end

  # GET /image_sets/1
  # GET /image_sets/1.xml                                                  HTML
  #----------------------------------------------------------------------------
  def show
    respond_to do |format|
      format.html { render :action => :index }
      format.xml  { @image_set = ImageSet.find(params[:id]);  render :xml => @image_set }
    end
  end

  # GET /image_sets/preview
  #----------------------------------------------------------------------------
  def preview
    @image_set_id = params[:id]
    @title = t(:preview_title, :scope => [:di, :image_sets])

    respond_to do |format|
      format.js   # preview.js.rjs
    end

  end

  # GET /image_sets/preview_frame                                          HTML
  #----------------------------------------------------------------------------
  def preview_frame
    @image_set_id = params[:id]
    @buttons = [
      { 
        :action  => :script,
        :method  => "Modalbox.hide();",
        :type    => :n,
        :caption => t(:button_cancel, :scope => [:di, :tasks]),
        :icon    => :cross
      }  
    ]

    respond_to do |format|
      format.html   { render :layout => false, :content_type => 'text/html' }
    end

  end

  # GET /image_sets/preview_gallery                                        HTML
  #----------------------------------------------------------------------------
  def preview_gallery
    @image_set_id = params[:id]

    respond_to do |format|
      format.html   { render :layout => false, :content_type => 'text/html' }
    end

  end

  # GET /image_sets/gallery_xml.xml                                        HTML
  #----------------------------------------------------------------------------
  def gallery_xml
    @image_set = ImageSet.find(params[:id])

    respond_to do |format|
      format.xml
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:xml)
  end

  # GET /image_sets/new
  # GET /image_sets/new.xml                                                AJAX
  #----------------------------------------------------------------------------
  def new
    @image_set = ImageSet.new
    if params[:related]
      model, id = params[:related].split("_")
      instance_variable_set("@asset", model.classify.constantize.my(@current_user).find(id))
    end

    respond_to do |format|
      format.js   # new.js.rjs
      format.xml  { render :xml => @image_set }
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_related_not_found(model, :js) if model
  end

  # GET /image_sets/1/edit                                                 AJAX
  #----------------------------------------------------------------------------
  def edit
    @image_set = ImageSet.find(params[:id])
    @asset = @image_set.asset if @image_set.asset_id?
    if params[:previous] =~ /(\d+)\z/
      @previous = ImageSet.find($1)
    end

  rescue ActiveRecord::RecordNotFound
    @previous ||= $1.to_i
    respond_to_not_found(:js) unless @image_set
  end

  # POST /image_sets
  # POST /image_sets.xml                                                   AJAX
  #----------------------------------------------------------------------------
  def create
    
    @image_set = ImageSet.new(params[:image_set])

    respond_to do |format|
      if @image_set.save
        update_sidebar if called_from_index_page?
        format.js   # create.js.rjs
        format.xml  { render :xml => @image_set, :status => :created, :location => @image_set }
      else
        format.js   # create.js.rjs
        format.xml  { render :xml => @image_set.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /image_sets/1
  # PUT /image_sets/1.xml                                                  AJAX
  #----------------------------------------------------------------------------
  def update
    @image_set = ImageSet.find(params[:id])
    @image_set_before_update = @image_set.clone

    respond_to do |format|
      if @image_set.update_attributes(params[:image_set])
        update_sidebar if called_from_index_page?
        format.js   # update.js.rjs
        format.xml  { head :ok }
      else
        format.js   # update.js.rjs
        format.xml  { render :xml => @image_set.errors, :status => :unprocessable_entity }
      end
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:js, :xml)
  end

  # DELETE /image_sets/1
  # DELETE /image_sets/1.xml                                               AJAX
  #----------------------------------------------------------------------------
  def destroy
    @image_set = ImageSet.find(params[:id])
    @image_set.destroy if @image_set

    update_sidebar if called_from_index_page?
    respond_to do |format|
      format.js   # destroy.js.rjs
      format.xml  { head :ok }
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:js, :xml)
  end

  # POST /image_sets/auto_complete/query                                   AJAX
  #----------------------------------------------------------------------------
  # Handled by before_filter :auto_complete, :only => :auto_complete

  # Ajax request to filter out a list of image_sets.                       AJAX
  #----------------------------------------------------------------------------
  def filter
    update_session do |filters|
      if params[:checked].true?
        filters << params[:filter]
      else
        filters.delete(params[:filter])
      end
    end
  end


  private

  # Yields array of current filters and updates the session using new values.
  #----------------------------------------------------------------------------
  def update_session
    name = "filter_by_image_set"
    filters = (session[name].nil? ? [] : session[name].split(","))
    yield filters
    session[name] = filters.uniq.join(",")
  end

  # Collect data necessary to render filters sidebar.
  #----------------------------------------------------------------------------
  def update_sidebar
    @image_set_total = ImageSet.totals

    # Update filters session if we added, deleted, or completed a image_set.
    if @image_set
      update_session do |filters|
        if @empty_bucket  # deleted, completed, rescheduled, or reassigned and need to hide a bucket
          filters.delete(@empty_bucket)
        elsif !@image_set.deleted_at && !@image_set.completed_at # created new image_set
          filters << @image_set.computed_bucket
        end
      end
    end

    # Create default filters if filters session is empty.
    name = "filter_by_image_set"
    unless session[name]
      filters = @image_set_total.keys.select { |key| key != :all && @image_set_total[key] != 0 }.join(",")
      session[name] = filters unless filters.blank?
    end
  end

end
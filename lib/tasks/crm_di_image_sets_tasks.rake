
namespace :crm do

  namespace :di do

    namespace :image_sets do
      
      desc "Setup DI image extentions"  
      task :setup => :environment do

        puts "\n" << ("=" * 80) << "\n= Installing DI image set extentions\n" << ("=" * 80)

        create_lookup("opportunity.imageset.type", "Opportunity Image Set Type")
        create_lookup("imageset.type", "Image Set Type")
        create_lookup("imageset.account", "Image Set Flickr Account")

        puts ("=" * 80) << "\n= Installed DI image set extentions\n" << ("=" * 80) << "\n\n"

      end


      desc "Setup DI image set extentions demonstation data"  
      task :demo => :environment do

        items = [
                  ['imageset.type',             'General',      'General',   'lightgreen', [] ],
                  ['imageset.account',          'delta.indigo', 'Global',    'lightgreen', [] ],
                  ['opportunity.imageset.type', 'Inspector',    'Inspector', 'lightgreen', [] ],
                  ['opportunity.imageset.type', 'Vendor',       'Vendor',    'lightblue',  [] ],
                  ['opportunity.imageset.type', 'Other',        'Other',     'gainsboro',  [] ]
                ]
 
        puts "\n" << ("=" * 80) << "\n= Installing DI image set extentions demonstration data\n" << ("=" * 80)

        puts "Checking lookups\n" << ("=" * 80)
        test = check_lookups_for_items(items)
        errors = ""
        test.each {|k, v| errors << ((errors.empty? ? "" : ", ") + "'" + k + "'") if !v }

        if !errors.empty? 
          puts "Required lookup(s) #{errors} missing, run 'rake crm:di:image_sets:setup' to install required lookups" 
        else
          puts "Required lookups found"
          puts "=" * 80
          puts "Adding new lookup values"
          puts "=" * 80
          add_lookup_items items
        end

        puts ("=" * 80) << "\n= " << (errors.empty? ? "Installed" : "Failed to install") << " DI image set extentions demonstration data\n" << ("=" * 80) << "\n\n"

      end

    end
  
  end

end

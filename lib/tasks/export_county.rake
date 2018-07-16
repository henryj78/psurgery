namespace :export_county do
  desc "Prints County.all in a seeds.rb way."
  task :seeds_format => :environment do
    County.order(:id).all.each do |county|
      puts "County.create(#{county.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end
end

namespace :export_zone do
  desc "Prints Zone.all in a seeds.rb way."
  task :seeds_format => :environment do
    Zone.order(:id).all.each do |zone|
      puts "Zone.create(#{zone.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end
end

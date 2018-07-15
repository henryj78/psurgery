namespace :export do
  desc "Prints Zipcode.all in a seeds.rb way."
  task :seeds_format => :environment do
    Zipcode.order(:id).all.each do |zipcode|
      puts "Zipcode.create(#{zipcode.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end
end

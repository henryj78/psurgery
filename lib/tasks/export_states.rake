namespace :export_states do
  desc "Prints State.all in a seeds.rb way."
  task :seeds_format => :environment do
    State.order(:id).all.each do |state|
      puts "State.create(#{state.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end
end

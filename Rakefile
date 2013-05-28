require "bundler/gem_tasks"

task :default => "lib/dot_parser.tab.rb"

file "lib/dot_parser.tab.rb" => "racc/dot.y" do |t|
  sh "racc #{t.prerequisites.first} -o #{t.name}"
end


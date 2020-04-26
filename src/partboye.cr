require "phreak"
require "yaml"
shard = YAML.parse(File.read("./shard.yml"))

running = false

module Partboye
  Phreak.parse! do |partboye|
    partboye.banner = "A psuedo partition manager."

    partboye.bind(short_flag: 'v', long_flag: "version",
      description: "Shows the version of Partboye.") do
      puts "Partboye v#{shard["version"]}"
    end

    partboye.bind(word: "help", short_flag: 'h', long_flag: "help",
      description: "Shows commands for Partboye.") do
      puts partboye
    end

    partboye.default do
      running = true
    end
  end

  pb = Phreak.create_parser do |partboye|
    partboye.bind(word: "list") do |sub|
      puts "Couldn't find partitions."
    end
  end
end

while running
  printf "> "
  line = gets || ""

  pb.parse(line.split(" "))
end

require 'rubygems'
require 'jekyll'

module JekyllDocs
  class DocsCommand < Jekyll::Command
    class << self
      def init_with_program(prog)
        prog.command(:docs) do |cmd|
          cmd.description "Start a local server for the Jekyll documentation"
          cmd.syntax "docs [options]"
          cmd.alias :d

          cmd.option "port", "-P", "--port", "Port to listen on."

          cmd.action do |_, opts|
            JekyllDocs::DocsCommand.process(opts)
          end
        end
      end

      def process(opts)
        Dir.mktmpdir do |dest_dir|
          Jekyll::Commands::Serve.process(opts.merge({
            "serving"     => true,
            "watch"       => false,
            "config"      => File.expand_path("../../site/_config.yml", __FILE__),
            "source"      => File.expand_path("../../site/", __FILE__),
            "destination" => dest_dir
          }))
        end
      end
    end
  end
end

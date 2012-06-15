require 'trollop'

module Heirloom
  module CLI
    def self.start
      @opts = Trollop::options do
        banner <<-EOS
I build and manage artifacts

Usage:

heirloom list
heirloom versions -n NAME
heirloom show -n NAME -i VERSION
heirloom build -n NAME -i VERSION
heirloom destroy -n NAME -i VERSION
EOS
        opt :help, "Display Help"
        opt :accouts, "AWS accounts who can read the artifact"
        opt :directory, "Source directory of artifact build.", :type => :string
        opt :id, "Version of artifact.", :type => :string
        opt :name, "Name of artifact.", :type => :string
        opt :public, "Is this artifact public?"
      end

      cmd = ARGV.shift
      a = Artifact.new :config => nil

      case cmd
      when 'list'
        puts a.list
      when 'versions'
        puts a.versions :name => @opts[:name]
      when 'show'
        puts a.show(:name => @opts[:name],
                    :version => @opts[:id]).to_yaml
      when 'build'
        a.build :name => @opts[:name],
                :id => @opts[:id],
                :accounts => @opts[:accounts],
                :directory => @opts[:directory],
                :public => @opts[:public]
      when 'destroy', 'delete'
        a.destroy :name => @opts[:name],
                  :id => @opts[:id]
      else
        puts "Unkown command: '#{cmd}'."
      end
    end
  end
end

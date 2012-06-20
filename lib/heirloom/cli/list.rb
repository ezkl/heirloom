module Heirloom
  module CLI
    class List

      def initialize(args)
        @artifact = Artifact.new :name   => args[:name],
                                 :logger => args[:logger]
      end
      
      def list
        @logger = Logger
        puts @artifact.list
      end

    end
  end
end
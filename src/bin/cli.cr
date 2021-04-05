require "../cristgraphia"
require "easy-cli"

class Cristgraphia::CLI < Easy_CLI::CLI
    def initialize
      name "cristgraphia"
    end
end

cli = Cristgraphia::CLI
cli.run(ARGV)
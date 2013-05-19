require 'rubygems'
require 'sinatra'
get '/' do
  "welcome to a whole new playground"
end

get '/pick/word/:word' do
  words = [ %w[their there they're],
            %w[too two to]
          ].inject({}){ |hsh,ary|
                        ary.inject(hsh){ |h,x|
                                       h.merge(x => ary)
                                     }
                      }
  words[params[:word]].sample
end

get '/roll/*' do
  rolls = []
  params[:splat].first.split('/').each do |dice|
    max = dice.match(/^d(\d+)/).to_a.last
    puts max
    rolls.push(rand(1..max))
  end
  puts rolls
end

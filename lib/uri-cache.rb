#
#  uri-cache.rb
#
#  Copyright (c) 2020 by Daniel Kelley
#
# Simple URI cache to limit hammering on a web server

require 'open-uri'
require 'fileutils'
require 'cgi'

class URICache


  def initialize(location)
    @location = location
    FileUtils.mkdir_p @location
  end

  def uri_location(uri)
    c_uri = CGI.escape uri
    "#{@location}/#{c_uri}"
  end

  def cache_uri(uri, location)
    raise "oops" if !ENV["NONET"].nil?
    URI.open(uri) do |u|
      File.open(location, "w") do |f|
        f.write(u.read)
      end
    end
  end

  def read_cached_uri(location)
    File.open(location, "r") do |f|
      f.read
    end
  end

  def get(uri)
    location = uri_location(uri)
    if (!File.exist?(location))
      cache_uri(uri, location)
    end
    read_cached_uri(location)
  end

end

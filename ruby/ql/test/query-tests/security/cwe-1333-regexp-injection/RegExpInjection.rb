class FooController < ActionController::Base
  # BAD
  def route0
    name = params[:name] # $ Source
    regex = /#{name}/ # $ Alert
  end

  # BAD
  def route1
    name = params[:name] # $ Source
    regex = /foo#{name}bar/ # $ Alert
  end

  # BAD
  def route2
    name = params[:name] # $ Source
    regex = Regexp.new(name) # $ Alert
  end

  # BAD
  def route3
    name = params[:name] # $ Source
    regex = Regexp.new("@" + name) # $ Alert
  end

  # GOOD - string is compared against a constant string
  def route4
    name = params[:name]
    regex = Regexp.new("@" + name) if name == "foo"
  end

  # GOOD - string is compared against a constant string array
  def route5
    name = params[:name]
    if ["John", "Paul", "George", "Ringo"].include?(name)
      regex = /@#{name}/
    end
  end

  # GOOD - string is explicitly escaped
  def route6
    name = params[:name]
    regex = Regexp.new(Regexp.escape(name))
  end

  # GOOD - string is explicitly escaped
  def route7
    name = params[:name]
    regex = Regexp.new(Regexp.quote(name))
  end

  # BAD
  def route8
    name = params[:name] # $ Source
    regex = Regexp.compile("@" + name) # $ Alert
  end

  # Conservatively reported, although Regexp.union escapes string arguments.
  def route9
    name = params[:name] # $ Source
    regex = Regexp.union(name) # $ Alert
  end

  def route10
    name = params[:name] # $ Source
    regex = Regexp.union(name, /fixed/) # $ Alert
  end

  def route11
    name = params[:name] # $ Source
    regex = Regexp.union(/fixed/, name) # $ Alert
  end

  def route12
    name = params[:name] # $ Source
    regex = Regexp.union(/first/, /second/, name) # $ Alert
  end

  def route13
    name = params[:name] # $ Source
    regex = Regexp.union([/fixed/, name]) # $ Alert
  end

  def route14
    name = params[:name] # $ Source
    patterns = [/fixed/, name]
    regex = Regexp.union(patterns) # $ Alert
  end

  def route15
    name = params[:name] # $ Source
    patterns = [/fixed/, name]
    regex = Regexp.union(*patterns) # $ Alert
  end

  # GOOD - explicit escaping still acts as a sanitizer.
  def route16
    name = params[:name]
    regex = Regexp.union(Regexp.escape(name))
    regex = Regexp.union([/fixed/, Regexp.quote(name)])
  end

  # GOOD - only constant patterns.
  def route17
    regex = Regexp.union
    regex = Regexp.union([])
    regex = Regexp.union("fixed", /pattern/)
    regex = Regexp.union(["fixed", /pattern/])
  end

  # GOOD - a different receiver's union method is not a sink.
  def route18
    name = params[:name]
    result = [1, 2].union([name])
  end
end

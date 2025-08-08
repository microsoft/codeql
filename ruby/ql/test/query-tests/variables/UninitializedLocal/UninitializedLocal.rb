def m
  puts "m"
end

def foo
  m # calls m above
  if false
      m = "0"
      m # reads local variable m
  else
  end
  m.strip  #$ Alert
  m2 # undefined local variable or method 'm2' for main (NameError)
end

def test_guards
    if (a = "3" && a)  # OK - a is in a Boolean context
        a.strip
    end
    if (a = "3") && a  # OK - a is assigned in the previous conjunct
        a.strip
    end
    if !(a = "3") or a  # OK - a is assigned in the previous conjunct
        a.strip
    end
    if false
        b = "0"
    end
    b.nil?
    b || 0  # OK
    b&.strip  # OK - safe navigation
    b.strip if b  # OK
    b.close if b && !b.closed # OK
    b.blowup if b || !b.blownup #$ Alert

    if false
        c = "0"
    end
    unless c
        return
    end
    c.strip  # OK - given above unless

    if false
        d = "0"
    end
    if (d.nil?)
        return
    end
    d.strip # OK - given above check

    if false
        e = "0"
    end
    unless (!e.nil?)
        return
    end
    e.strip  # OK - given above unless
end

def test_loop
    begin
        if false
            a = 0
        else
            set_a
        end   
    end until a  # OK
    a.strip  # OK - given previous until
end

def test_for
    for i in ["foo", "bar"]  # OK - since 0..10 cannot raise
        puts i.strip
    end
    i.strip  #$ SPURIOUS: Alert
end
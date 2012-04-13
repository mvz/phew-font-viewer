require 'gir_ffi'

GirFFI.setup :Atspi

class Foo < GObject::Object
  include Atspi::Action
end

module Atspi
  load_class :Accessible
  class Accessible
    def each_child
      child_count.times do |idx|
        child = get_child_at_index idx
        yield child
      end
    end

    def inspect_recursive level=0, maxlevel=4
      each_child do |child|
        act = child.action
        if act
          act = Foo.wrap(act.to_ptr)
          nactions = act.get_n_actions
          actlist = nactions.times.map do |nth|
            "#{act.get_description nth} <#{act.get_key_binding nth}>"
          end
          actions = "; actions: [#{actlist.join ', '}]"
        else
          actions = ""
        end
        puts "#{'  ' * level} > name: #{child.name}; role: #{child.role}#{actions}"
        child.inspect_recursive(level + 1) unless level >= maxlevel
      end
    end
  end
end

desktop = Atspi.get_desktop(0)

desktop.inspect_recursive

desktop.each_child do |app|
  if app.name == 'gnome-shell'
    child = app.get_child_at_index 0
    act = child.action
    nactions = act.get_n_actions
    puts "#{child.name} has #{nactions} actions"
    nactions.times do |nth|
      puts "Action #{nth} is #{act.get_description nth} with keybinding #{act.get_key_binding nth}."
    end
  end
end

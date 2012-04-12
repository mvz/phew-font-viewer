require 'gir_ffi'

GirFFI.setup :Atspi

desktop = Atspi.get_desktop(0)

p desktop.name
p desktop.role
p desktop.role_name
p desktop.child_count

cnt = desktop.child_count
(0..cnt-1).each do |i|
  child = desktop.get_child_at_index i
  p child.name
end

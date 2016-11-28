class Object
  def try(method_name = itself)
    return nil if self.nil?

    return yield(self) if block_given?

    return self.send(method_name) if self.respond_to? method_name

    self
  end
end
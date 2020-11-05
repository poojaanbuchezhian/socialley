class Object
  def valid_int?
    begin
      Integer(self)
      true
    rescue ArgumentError
      false
    end
  end
  def valid_float?
    begin
      Float(self)
      true
    rescue ArgumentError
      false
    end
  end
end

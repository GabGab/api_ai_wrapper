class String

  def demodulize
    if i = self.rindex("::")
      self[(i + 2)..-1]
    else
      self
    end
  end

  def underscore
    return self unless /[A-Z-]|::/.match?(self)
    word = self.gsub("::".freeze, "/".freeze)
    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2'.freeze)
    word.gsub!(/([a-z\d])([A-Z])/, '\1_\2'.freeze)
    word.tr!("-".freeze, "_".freeze)
    word.downcase!
    word
  end

end
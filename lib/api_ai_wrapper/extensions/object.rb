# Object Override taken from Rails
class Object
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end

  def present?
    !blank?
  end

  def presence
    self if present?
  end
end
class Tile
  attr_reader :value, :given

  def initialize(num)
    if num == "0"
      @given = false
      @value = nil
    else
      @given = true
      @value = num
    end
  end

  def value=(val)
      @value = val unless @given
  end

  def to_s
    @value.nil? ? "*" : @value
  end
end

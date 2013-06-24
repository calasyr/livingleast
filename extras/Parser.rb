class Parser
 
  def initialize(body)
    raise unless body.is_a?(String)
    @body = body

    x = body.scan(/was recently used at a ([a-z\s]+)\s(.+)?\s+in\s+(.+)?\s+for\s+a\s+(\d+\.\d+)\s+(.+)?\s+purchase/)

    @valid = x.any?

    if @valid
      @category = x[0][0]
      @merchant = x[0][1]
      @location = x[0][2]
      @amount = x[0][3].to_f
      @currency = x[0][4]
    else
      x = body.scan(/was\s+recently\s+used\s+at\s+(.+)?\s+in\s+(.+)?\s+for\s+a\s+(\d+\.\d+)\s+(.+)?\s+(purchase|without)/)
      @valid = x.any?

      if @valid
        @merchant = x[0][0]
        @location = x[0][1]
        @amount = x[0][2].to_f
        @currency = x[0][3]
        @category = "N/A"
      else
        x = body.scan(/was\s+used\s+at\s+(.+)?\s+for\s+(\d+\.\d+)\s+(.+)?\s+without/)
        @valid = x.any?

        if @valid
          @merchant = x[0][0]
          @amount = x[0][1].to_f
          @currency = x[0][2]
          @location = "N/A"
          @category = "N/A"
        end

      end
    end
  end

  def merchant
    @merchant
  end

  def amount
    @amount
  end

  def location
    @location
  end

  def category
    @category
  end

  def currency
    @currency
  end

  def valid?
    @valid
  end

end
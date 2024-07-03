class Expirable::Advisory
  def initialize(expirable)
    @expirable = expirable
  end

  def send
    Expirable::AdvisoryMailer.with(expirable: @expirable).send(sym).deliver_later
  end

  private

  def sym
    self.class.name.split("::")[2].downcase.to_sym
  end
end

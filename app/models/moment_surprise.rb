class MomentSurprise < Surprise
  belongs_to :moment
  validates :nb_persons, presence:true
  validates :moment_day, presence:true
  validates :ticket_price, presence:true
end

module Member::Petitioner
  extend ActiveSupport::Concern

  included do
    has_one :clearance_petition, class_name: "Clearance", dependent: :destroy, inverse_of: :petitioner, as: :petitioner, autosave: true
    default_scope -> { where.missing(:clearance_petition) unless !Config.clearing }
    scope :include_petitioners, -> { unscope(where: :id) }
    scope :petitioners, -> { include_petitioners.where.associated(:clearance_petition) }

    delegate :approve!, to: :clearance_petition
    delegate :reject!, to: :clearance_petition
  end

  def petitioning?
    clearance_petition.present?
  end
end

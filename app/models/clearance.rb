class Clearance < ApplicationRecord
  self.table_name = "clearance_petitions"

  belongs_to :petitioner, -> { unscope(:where) }, polymorphic: true

  def approve!
    My::MembershipMailer.with(member: petitioner).created.deliver_later
    petitioner.update!(clearance_petition: nil)
    destroy!
  end

  def reject!
    My::MembershipMailer.with(member: petitioner).rejected.deliver_now
    petitioner.destroy!
    destroy!
  end

  after_create_commit do
    ClearanceMailer.with(petitioner: petitioner).administrator_alert.deliver_later
  end
end

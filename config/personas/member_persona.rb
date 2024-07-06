# frozen_string_literal: true

DemoMode.add_persona do
  # See README at https://github.com/Betterment/demo_mode

  sign_in_as do
    FactoryBot.create(:member)
  end

  # Features that make this persona unique:
  features << "Average Joe"

  # "Callout" personas render at the top, above the table:
  callout true

  icon "demo_mode/icon--user.png"

  begin_demo do
    sign_in @session.signinable
    redirect_to "/my/membership"
  end
end

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

  # Use the `icon` config to change the persona's icon.
  #
  # Built-in icons include `:user` (default), `:users`, and `:tophat`:
  # ==========
  # icon :user
  #
  # Specify a string to use an asset in the asset pipeline:
  # =======================================================
  # icon 'path/to/my/icon.png'
  #
  # Specify a block to render your own icon:
  # ========================================
  icon do
    image_tag("demo_mode/icon--user.png")
  end

  # Define "variants" with the `variant` keyword:
  # =============================================
  # variant 'pending invite' do
  #   sign_in_as do
  #     FactoryBot.create(:user, :pending_invite)
  #   end
  # end

  # Display the login credentials before signing in:
  # ================================================
  # display_credentials

  # To do something other than "sign in"
  # (e.g. redirect to an exclusive sign up link)
  # ============================================
  begin_demo do
    sign_in @session.signinable
    redirect_to "/my/membership"
  end
end

#
# ActiveAdminVersioning Configuration
#
ActiveAdminVersioning.configure do |config|
  # In some cases you may need to display some extra or formatted text in whodunnit.
  # For example whodunit is an ID of your user. And you want to display not just a number, but his E-mail.
  #
  # In you model:
  #
  # has_paper_trail class_name: 'MyPaperTrail'
  #
  # class MyPaperTrail < PaperTrail::Version
  #   def display_whodunnit
  #     AdminUser.find(whodunnit).email
  #   end
  # end
  #
  # config.whodunnit_attribute_name = :whodunnit

  # You might want to change the way the current user is set.
  # You can do that using the `user_for_paper_trail` configuration.
  #
  # config.user_for_paper_trail = :admin_user_for_paper_trail
end

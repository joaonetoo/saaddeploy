# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( quiz.js )
Rails.application.config.assets.precompile += %w( quizzes.js )
Rails.application.config.assets.precompile += %w( results.js )
Rails.application.config.assets.precompile += %w( registrations.js )
Rails.application.config.assets.precompile += %w( subjects.js )
Rails.application.config.assets.precompile += %w( admin.js )
Rails.application.config.assets.precompile += %w( administrators.js )
Rails.application.config.assets.precompile += %w( anchorinfos.js )
Rails.application.config.assets.precompile += %w( anchors.js )
Rails.application.config.assets.precompile += %w( campus.js )
Rails.application.config.assets.precompile += %w( centers.js )
Rails.application.config.assets.precompile += %w( classrooms.js )
Rails.application.config.assets.precompile += %w( coordinators.js )
Rails.application.config.assets.precompile += %w( courses.js )
Rails.application.config.assets.precompile += %w( institutions.js )
Rails.application.config.assets.precompile += %w( principals.js )
Rails.application.config.assets.precompile += %w( students.js )
Rails.application.config.assets.precompile += %w( teachers.js )
Rails.application.config.assets.precompile += %w( users.js )
Rails.application.config.assets.precompile += %w( welcome.js )
Rails.application.config.assets.precompile += %w( createPdf.js )
Rails.application.config.assets.precompile += %w( createCsv.js )
Rails.application.config.assets.precompile += %w( pdfmake.min.js )
Rails.application.config.assets.precompile += %w( vsf_fonts.js )
Rails.application.config.assets.precompile += %w( jspdf.min.js )
Rails.application.config.assets.precompile += %w( jspdf.plugin.text-align.js )
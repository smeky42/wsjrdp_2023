# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

module Wsjrdp2023
  module Export::Pdf
    module GroupRegistration
      class Runner
        def render(group, pdf_preview)
          new_pdf(group, pdf_preview).render
        end

        # rubocop:disable Metrics/AbcSize
        # rubocop:disable Metrics/MethodLength
        def new_pdf(group, pdf_preview)
          pdf = Prawn::Document.new(page_size: 'A4',
                                    page_layout: :portrait,
                                    margin: 2.cm,
                                    bottom_margin: 1.cm)

          sections.each { |section| section.new(pdf, group).render }

          # define header & footer variables
          imagePath = '../hitobito_wsjrdp_2023/app/assets/images/'

          pdf.y = 850
          # pdf.page_count = 0
          pdf.repeat :all do

            logo = Rails.root.join(imagePath + 'jamb-logo.png')
            pdf.bounding_box [350, 770], width: pdf.bounds.width, height: 375 do
              pdf.image logo, width: 100
              # pdf.move_up 15
            end


            header = Rails.root.join(imagePath + 'header.png')
            pdf.bounding_box [-58, 815], width: pdf.bounds.width, height: 275 do
              pdf.image header, width: 300
            end



            pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 10], width: pdf.bounds.width do
              pdf.text group.id.to_s + ' - ' + group.name, size: 8
            end
          end

          pdf.number_pages 'Seite <page> von <total>',
                           at: [pdf.bounds.left, pdf.bounds.bottom], size: 8

          pdf
        end
        # rubocop:enable Metrics/AbcSize
        # rubocop:enable Metrics/MethodLength

        def customize(pdf)
          pdf.font_size 9
          pdf
        end

        def sections
          []
        end
      end
      mattr_accessor :runner
      self.runner = Runner

      def self.render(group, pdf_preview)
        runner.new.render(group, pdf_preview)
      end

      def self.new_pdf(group, pdf_preview)
        runner.new.new_pdf(group, pdf_preview)
      end


    end
  end
end

# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

module Wsjrdp2023
  module Export::Pdf
    module Registration
      class Runner
        def render(person, pdf_preview)
          new_pdf(person, pdf_preview).render
        end

        # rubocop:disable AbcSize
        # rubocop:disable MethodLength
        def new_pdf(person, pdf_preview)
          pdf = Prawn::Document.new(page_size: 'A4',
                                    page_layout: :portrait,
                                    margin: 2.cm,
                                    bottom_margin: 1.cm)

          sections.each { |section| section.new(pdf, person).render }

          # define header & footer variables
          imagePath = '../hitobito_wsjrdp_2023/app/assets/images/'

          pdf.y = 850
          # pdf.page_count = 0
          pdf.repeat :all do
            # define header
            if pdf_preview
              pdf.bounding_box [0, 750], width: pdf.bounds.width, height: 200 do
                pdf.transparent(0.5) do
                  pdf.text 'Vorschau:', size: 24
                  pdf.text 'Nicht zum Versand gedacht!', size: 24
                end
              end
            end

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
              pdf.text person.id.to_s + ' - ' + person.full_name + ' '\
               + person.birthday.strftime('%d.%m.%Y'), size: 8
            end
          end

          pdf.number_pages 'Seite <page> von <total>, Signatur Gesamtdokument: ',
                           at: [pdf.bounds.left, pdf.bounds.bottom], size: 8

          pdf
        end
        # rubocop:enable AbcSize
        # rubocop:enable MethodLength

        def customize(pdf)
          pdf.font_size 9
          pdf
        end

        def sections
          [Contract, Medicin, Travel, Media, DataAgreement, DataProcessing]
        end
      end
      mattr_accessor :runner
      self.runner = Runner

      def self.render(person, pdf_preview)
        runner.new.render(person, pdf_preview)
      end

      def self.new_pdf(person, pdf_preview)
        runner.new.new_pdf(person, pdf_preview)
      end

    end
  end
end

# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.
require 'prawn/qrcode'
require 'digest'

module Wsjrdp2023
  module Export::Pdf::GroupRegistration
    class Groupsheet < Section

      # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Metrics/CyclomaticComplexity
      def render
        bounding_box([0.mm,220.mm], :width => 85.mm, :heigth => 45.mm) do
            font_size(10) do
              pdf.text "Peter Neubauer "
              pdf.text "Worldscoutjamboree Anmeldung"
              pdf.text "Zum Steinbruch 21 A"
              pdf.text "90411 Nürnberg"
            end

          end

        pdf.y = bounds.height - 60
        bounding_box([0, 200.mm], width: bounds.width, height: bounds.height - 250) do
          font_size(8) do
            text list, style: :italic, width: bounds.width
          end
        end
      end

      def list
        member_count = @members.count
        approved_member_count = @members.where(status: "bestätigt durch Leitung").count
        if (member_count != approved_member_count )
          text "Deine Gruppe hat #{member_count} Mitglieder, du hast aber erst #{approved_member_count} durch scannen des QR Codes bestätigt. Du kannst die Gruppenanmeldung erst versenden, wenn alle bestätigt sind.", size: 14
        end

        pdf.move_down 3.mm
        text "Gruppenanmeldung - #{@group.name}", size: 12
        
        pdf.move_down 3.mm
        text "Um die Anmeldung für alle Teilnehmenden der Unit #{@group.name} abzuschließen muss diese Gruppenanmeldung unterschrieben an die obenstehende Adresse verschickt werden."

        pdf.move_down 3.mm
        text 'Hiermit bestätige ich, dass ich die Anmeldeunterlagen folgender Gruppenmitglieder im Orginal geprüft habe:'

        @members.each do |person|
          text "#{person.id} - #{person.first_name} #{person.last_name} , geb. am #{person.birthday.strftime('%d.%m.%y')}"
        end 

        pdf.move_down 3.mm
        
        text 'Insbesondere habe ich geprüft, dass'
        text '- die "Anmeldung" vollständig und korrekt unterschrieben ist'
        text '- das "Sepa-Mandat" vollständig und korrekt unterschrieben ist'
        text '- keine Änderungen an den Orginaldokumenten vorgenommen wurden'
        text '- Vor- und Nachnamen auf Ausweis und Anmeldung exakt übereinstimmen (inklusive Zweitnamen etc.)'
        text '- Geburtsdatum auf Ausweis und Anmeldung übereinstimmen'

        pdf.move_down 3.mm
        text 'Die Anmeldungen und die Sepa-Mandate aller, oben aufgelisteten, Gruppenmitglieder liegen der Gruppenanmeldung im Orginal bei.'

        pdf.move_down 3.mm
        text 'Den Medizinbogen aller Gruppenmitglieder habe ich erhalten und die Unterschriften geprüft.'
        text '(Der Medizinbogen bleibt bei den jeweilig verantwortlichen Gruppenleitern und soll nicht mit versand werden.)'

        pdf.make_table([
                                       [{ content: '', height: 30 }],
                                       %w(____________________________________________________),
                                       [{ content: 'Ort, Datum, Name des Leiters', height: 30 }],
                                       ['______________________________', ''],
                                       [{ content: 'Unterschrift', height: 30 }, '']
                                     ],
                                     cell_style: { width: 240, padding: 1, border_width: 0,
                                                   inline_format: true }).draw 


      text ''
      end
    end
    # rubocop:enable Metrics/AbcSize,Metrics/MethodLength,Metrics/CyclomaticComplexity


  end
end

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

      # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      def render
        bounding_box([0.mm, 220.mm], width: 85.mm, heigth: 45.mm) do
          font_size(10) do
            pdf.text 'Peter Neubauer '
            pdf.text 'Worldscoutjamboree Anmeldung'
            pdf.text 'Zum Steinbruch 21 A'
            pdf.text '90411 Nürnberg'
          end

        end

        @member_count = @members.count
        @ul_approved_member_count = @members.where(status: 'bestätigt durch Leitung').count
        @fully_approved_member_count = @members.where(status: 'vollständig').count
        @approved_member_count = @ul_approved_member_count + @fully_approved_member_count
        if @member_count != (@approved_member_count)
          bounding_box([0.mm, 250.mm], width: 100.mm, heigth: 45.mm) do
            text "Deine Gruppe hat #{@member_count} Mitglieder, du hast" \
                 " aber erst #{@approved_member_count} durch Scannen des" \
                 ' QR Codes bestätigt. Du kannst die Gruppenanmeldung erst' \
                 ' versenden, wenn alle Gruppenmitglieder bestätigt sind.', size: 14
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
        pdf.move_down 3.mm
        text "Gruppenanmeldung - #{@group.name} - #{@members.count} Mitglieder", size: 12

        pdf.move_down 3.mm
        text "Um die Anmeldung für alle Teilnehmenden der Unit #{@group.name} abzuschließen, muss diese Gruppenanmeldung unterschrieben und mit den orginalen Einzelanmeldungen an die obenstehende Adresse geschickt werden."

        pdf.move_down 3.mm
        text 'Hiermit bestätige ich, dass ich die Anmeldeunterlagen folgender Gruppenmitglieder im Orginal geprüft habe:'

        pdf.move_down 3.mm
        table_data = []
        (0..@members.count).each do |i|
          l_member = @members[i]
          r_member = @members[i + 1]
          if i.even?
            if !r_member.nil? && !l_member.nil?
              table_data << ["#{l_member.id}:", "#{l_member.first_name} #{l_member.last_name}",
                             ", geb. am #{l_member.birthday.strftime('%d.%m.%y')}", ' ', "#{r_member.id}:", "#{r_member.first_name} #{r_member.last_name}", ", geb. am #{r_member.birthday.strftime('%d.%m.%y')}"]
            elsif !l_member.nil?
              table_data << ["#{l_member.id}:", "#{l_member.first_name} #{l_member.last_name}",
                             ", geb. am #{l_member.birthday.strftime('%d.%m.%y')}", ' ', ' ', ' ', ' ']
            end
          end
        end

        pdf.table(table_data, width: 500, cell_style: { padding: 1, border_width: 0,
                                                        inline_format: true  })


        pdf.move_down 3.mm

        text 'Ich bestätige hiermit die oben genannten Gruppenmitglieder und habe insbesondere geprüft, dass'
        text '- die "Anmeldung" vollständig und korrekt unterschrieben ist'
        text '- das "Sepa-Mandat" vollständig und korrekt unterschrieben ist'
        text '- keine Änderungen an den Orginaldokumenten vorgenommen wurden'
        text '- Vor- und Nachnamen auf Ausweis und Anmeldung exakt übereinstimmen (inklusive Zweitnamen etc.)'
        text '- Geburtsdatum auf Ausweis und Anmeldung übereinstimmen'

        pdf.move_down 3.mm
        text 'Die Anmeldungen und die Sepa-Mandate aller, oben aufgelisteten Gruppenmitglieder liegen der Gruppenanmeldung im Orginal bei.'
        text 'Den Medizinbogen aller Gruppenmitglieder habe ich erhalten und die Unterschriften geprüft.'
        text '(Der Medizinbogen bleibt bei den jeweiligen verantwortlichen Gruppenleiter*innen und wird nicht mit versandt.)'

        pdf.move_down 10.mm
        table_data = []
        table_data << %w(______________________________ ______________________________
                         ______________________________)
        table_data << ['Ort, Datum', 'Name Unitleitung', 'Unterschrift']
        pdf.table(table_data, width: 500, cell_style: { padding: 1, border_width: 0,
                                                        inline_format: true  })
        # pdf.make_table([
        #                                [{ content: '', height: 30 }], %w(______________________________),
        #                                [{ content: 'Ort, Datum', height: 30 }],
        #                                ['______________________________', ''],
        #                                [{ content: 'Name Unitleitung', height: 30 }, ''],
        #                                ['______________________________', ''],
        #                                [{ content: 'Unterschrift', height: 30 }, '']
        #                              ],
        #                              cell_style: { width: 240, padding: 1, border_width: 0,
        #                                            inline_format: true }).draw


        text ''
      end
    end
    # rubocop:enable Metrics/AbcSize,Metrics/MethodLength


  end
end

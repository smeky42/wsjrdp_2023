# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

module Wsjrdp2023
  module Export::Pdf::Registration
    class Media < Section
      def render
        pdf.y = bounds.height - 60
        bounding_box([0, 230.mm], width: bounds.width, height: bounds.height - 200) do
          font_size(8) do
            text list, style: :italic, width: bounds.width
          end
        end
      end

      # rubocop:disable AbcSize,MethodLength
      def list
        pdf.start_new_page
        text '10. Anfertigung von Bild- und Tonaufnahmen', size: 12

        pdf.move_down 3.mm
        text '10.1 Der rdp wird die Veranstaltung und die Vorbereitungstreffen mit Bild- und'\
        + ' Tonaufnahmen dokumentieren. Die Parteien vereinbaren in diesem Zusammenhang,'\
        + ' dass Fotografen, die vom Veranstalter ausgewählt und beauftragt werden,'\
        + ' Lichtbilder des Teilnehmers aufnehmen dürfen.'
        text '10.2 Für die Aufnahme und Nutzung wird keine inhaltliche, zeitliche oder'\
        + ' räumliche Beschränkung vereinbart. Zulässig ist die Nutzung insbesondere für'\
        + ' folgende Zwecke:'
        pdf.indent(10) do
          text '
           • Veröffentlichung in den Medien der Mitgliedsverbände (z.B. Zeitschrift, Newsletter)
           • Veröffentlichung in der Presse (z.B. Pressefotos)
           • Veröffentlichung im Internet (z.B. auf den Homepages des Veranstalters oder eines '\
        +'Mitgliedsverbands oder den jeweiligen Auftritten bei Facebook, Instagramm  etc.)
           • Veröffentlichung in Werbemedien des Veranstalters oder eines Mitgliedsverbands '\
        +'(z.B. Flyer/Plakate)'
        end
        pdf.move_down 2.mm
        text '10.3 Der rdp ist berechtigt, die Aufnahmen innerhalb von Fotomontagen unter'\
        + ' Entfernung oder Ergänzung von Bildbestandteilen bzw. für verfremdete Bilder'\
        + ' (keine Entstellung) der Originalaufnahmen zu benutzen'
        pdf.move_down 1.mm
        text '10.4 Der rdp ist berechtigt, aber nicht verpflichtet, die Aufnahmen den'\
        + ' Mitgliedsverbänden unentgeltlich für die in 10.2 aufgezählten Zwecke zur'\
        + ' Verfügung zu stellten.'
        pdf.move_down 1.mm
        text '10.5 Der Teilnehmer überträgt dem rdp alle Rechte, die zur Ausübung der in'\
        + ' Ziff. 10.2 bis 10.4 aufgeführten Nutzungsrechte erforderlich sind. Die'\
        + ' Übertragung erfolgt örtlich und zeitlich unbeschränkt, unwiderruflich'\
        + ' und nicht ausschließlich. Eine gesonderte Vergütung erfolgt nicht.'
        pdf.move_down 1.mm
        text '10.6 Sollte ein Teilnehmer nicht gefilmt oder fotografiert werden wollen, so'\
        + ' soll er die jeweiligen Betreuer*innen hierauf jeweils vor Beginn der'\
        + ' Veranstaltung hinweisen. Der*Die Betreuer*in wird sich in diesem Fall'\
        + ' darum bemühen, die Fotografen darauf hinzuweisen, dass der Betroffene'\
        + ' nicht abgebildet werden möchte. Ein Erfolg kann nicht garantiert werden'\
        + ' und ist nicht geschuldet.'
        pdf.move_down 1.mm
        text '10.7 Bei Fragen zu der Anfertigung von Bild- und Tonaufnahmen und zu deren'\
        + ' Verwendung kann sich der Teilnehmer an die Email-Adresse'\
        + ' media-info@worldscoutjamboree.de wenden.'
        pdf.move_down 1.mm
        text 'Bei Fragen zu dieser Vereinbarung und zu den aufgenommenen Fotos und deren '\
        +' Verwendung steht unser Medienteam unter media@worldscoutjamboree.de zur Verfügung.'
      end
      # rubocop:enable AbcSize,MethodLength
    end
  end
end

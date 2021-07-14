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
        text 'Nutzung von Medien', size: 14
        pdf.move_down 3.mm
        text 'Nutzung von Fotografien und Filmen für die Berichterstattung'\
        +' des Rings deutscher Pfadfinder*innen e.V. (rdp) und ihrer Mitgliedsverbände für'\
        +' das World Scout Jamboree 2023', size: 12
        pdf.move_down 1.mm
        text 'Der*Die Teilnehmer*innen möchte an der oben genannten Veranstaltung teilnehmen. '\
        +'Sie*Er will es dem rdp, im speziellen dem Deutschen Kontingent (Veranstalter) '\
        +'ermöglichen, über das World Scout Jamboree zu berichten und dabei auch '\
        +'Bildmaterial zu verwenden. Mit der vorliegenden Vereinbarung vereinbaren '\
        +'die Vertragsparteien daher, dass während der Veranstaltung Fotograf*innen, '\
        +'die von den Veranstaltern ausgewählt und beauftragt werden, Lichtbilder auch '\
        +'vom Teilnehmenden aufnehmen dürfen und, dass die Veranstalter diese später nach '\
        +'Maßgabe der folgenden Bestimmungen verwenden dürfen.'
        pdf.move_down 1.mm
        text 'Zwischen dem Ring deutscher Pfadfinder*innen e.V. (rdp) und dem Teilnehmenden'\
        +' wird folgende Nutzungsvereinbarung für Fotografien und Videos getroffen:'
        pdf.move_down 1.mm
        text '1. Die Veranstalter sind berechtigt, aber nicht verpflichtet, von der o.g. '\
        +'Person Aufnahmen zu erstellen und dem Kontingent und den Mitgliedsverbänden des '\
        +'Ringes unentgeltlich zum Zwecke der Berichterstattung in Medien, zur Werbung und '\
        +'zur Verwendung nach Ziffer 2 zur Verfügung zu stellen. '
        pdf.move_down 1.mm
        text '2. Für die Aufnahme und Nutzung wird keine inhaltliche, zeitliche oder '\
        +'räumliche Beschränkung vereinbart. Die Nutzung ist für folgende Zwecke zulässig:'
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
        text '3. Die Veranstalter sind berechtigt, die aufgenommenen Bilder, die Fotos und Filme '\
        +'innerhalb von Fotomontagen unter Entfernung oder Ergänzung von Bildbestandteilen bzw. '\
        +'für verfremdete Bilder (keine Entstellung) der Originalaufnahmen zu benutzen.'
        pdf.move_down 1.mm
        text '4. Die Veranstalter verpflichten sich, Anfragen des Teilnehmenden zu Art und '\
        +'Umfang der Bild-Nutzung unverzüglich zu beantworten.'
        pdf.move_down 1.mm
        text '5. Die/der Fotografierte/Gefilmte überträgt dem Fotografen alle zur Ausübung '\
        +'der Nutzung gem. Ziffer 2 notwendigen Rechte an den erstellten Fotografien und Filmen. '
        pdf.move_down 1.mm
        pdf.move_down 1.mm
        text '6. Jegliche Änderung dieser Vereinbarung bedarf der Schriftform. Mündliche '\
        +'Nebenabreden sind nicht getroffen.'
        pdf.move_down 1.mm
        text '7. Sollten einzelne Klauseln der vorliegenden Vereinbarung unzulässig oder '\
        +'nichtig sein oder werden, so wird die Wirksamkeit der Vereinbarung und der übrigen '\
        +'Klauseln hiervon nicht berührt. Die Vertragsparteien verpflichten sich, in diesem '\
        +'Fall eine ähnliche Regelung zu treffen, die dem Ziel der betroffenen Klausel '\
        +'möglichst nahe kommt.'
        pdf.move_down 1.mm
        text 'Bei Fragen zu dieser Vereinbarung und zu den aufgenommenen Fotos und deren '\
        +' Verwendung steht unser Medienteam unter media@worldscoutjamboree.de zur Verfügung.'
      end
      # rubocop:enable AbcSize,MethodLength
    end
  end
end

# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

module Wsjrdp2023
  module Export::Pdf::Registration
    class Medicin < Section
      def render
        pdf.y = bounds.height - 60
        bounding_box([0, 230.mm], width: bounds.width, height: bounds.height - 200) do
          font_size(8) do
            text list, style: :italic, width: bounds.width
          end
        end
      end

      # rubocop:disable AbcSize
      # rubocop:disable MethodLength
      def list
        pdf.start_new_page
        text 'Gesundheitsfragebogen', size: 14
        text 'Von ' + @person.full_name
        text 'Erziehungsberechtigte: ' + ' TODO NAME 1 ' + ' TODO NAME 2'
        text 'im Notfall zu erreichen unter TODO'
        pdf.move_down 3.mm

        text 'Grundsätzlich:', size: 12
        pdf.move_down 1.mm
        text 'Änderungen müssen bis zum Antritt der Reise unverzüglich dem Veranstalter/dem '\
        + 'ärztlichem Team über die Anmeldung (anmeldung.worldscoutjamboree.de) mitgeteilt werden.'
        pdf.move_down 1.mm
        text 'Krankenversicherungskarte und Impfausweis sind mitzuführen. Der Gesundheitsbogen '\
        + 'ist von der Unitleitung mitzuführen.'

        pdf.move_down 3.mm
        text 'Schutzimpfungen :', size: 10
        text 'Vaccinations:', size: 6, style: :italic
        text 'Nur im Impfausweis dokumentierte Impfungen gelten als durchgeführt.'
        pdf.move_down 1.mm
        text ' Folgende Impfungen/Grundimmunisierung werden unsererseits empfohlen:'\
        + ' Hepatitis A & B.'
        pdf.move_down 1.mm
        text 'Außerdem werden reisemedizinisch für Touristen für Südkorea (Stand 31.03.2021) '\
        + 'weitere Impfungen empfohlen: Typhus, FSME, Jap Enzephaltitis, Meningokokken.'
        pdf.move_down 1.mm
        text 'Liste der Impfungen (Impfdatum Monat/Jahr) :'
        text '
        ... Liste der Impfungen mit Datum....

        '
        text 'Mein Kind hat die von der STIKO empfohlenen Schutzimpfungen:', size: 10
        text 'My child has the vaccinations recommended by the STIKO'\
        + ' (German Advisory Board for Vaccination):', size: 6, style: :italic
        text 'ja oder nein TODO Woher weiß ich das, brauchen wir das?'
        pdf.move_down 1.mm


        pdf.move_down 5.mm
        text 'Bekannte Vorerkrankungen / Operationen / Kinderkrankheiten:', size: 10
        text 'Known pre-existing conditions/surgeries/childhood illnesses:', size: 6, style: :italic
        pdf.move_down 1.mm
        text '
        ... Bekannte Vorerkrankungen ....

        '
        pdf.move_down 1.mm
        text 'Folgende Auffälligkeiten / Erkrankungen sind bekannt (z.B. Asthma, Reisekrankheit,'\
        + 'Epilepsie, Angststörung, AD(H)S, erhöhter Betreuungsaufwand, etc.) : ', size: 10
        text 'The following abnormalities / illnesses are known (e.g. asthma, motion sickness, '\
        + 'epilepsy, anxiety disorder, AD(H)S, increased care needs, etc.):', size: 6,
                                                                              style: :italic
        pdf.move_down 1.mm
        text '
        ... Auffälligkeiten  ...

        '
        pdf.move_down 1.mm
        text 'Es bestehen folgende Allergien (z.B. gegen Medikamente, nachgewiesene '\
        + 'Lebensmittelallergien, Heuschnupfen, etc.) mit folgenden Symptomen:', size: 10
        text 'The following allergies exist (e.g. to medications, proven food allergies, '\
        + 'hay fever, etc.) with the following symptoms:', size: 6, style: :italic
        pdf.move_down 1.mm
        text '
        ..... Allergien ......

        '
        pdf.move_down 1.mm
        text 'Es bestehen folgende Essensbesonderheiten mit folgenden Symptomen:', size: 10
        text 'The following eating disorders with the following symptoms '\
        + 'exist:', size: 6, style: :italic
        pdf.move_down 1.mm
        text '
        ..... Allergien ......

        '

        pdf.move_down 1.mm
        text 'Es besteht zur Zeit eine infektiöse Erkrankung, wenn ja welche:', size: 10
        text 'There is currently an infectious disease, if so which one:', size: 6, style: :italic
        pdf.move_down 1.mm
        text '
        ........ Erkrankungen ........

        '
        pdf.move_down 1.mm
        text 'Mein / Unser Kind befindet sich zur Zeit in ärztlicher Behandlung (behandelnder '\
        + 'Arzt Facharzt - Name, Kontaktdaten). Es wird bei Bedarf gestattet, dass sich das '\
        + 'ärztliche Team der Kontingentsleitung mit dem gennannten med. Fachpersonal in '\
        + 'Kontakt setzten darf, um Gesundheitsdaten / Informationen auzutauschen '\
        + '(Schweigepflichtsentbindung) :', size: 10
        text 'My / Our child is currently undergoing medical treatment (attending physician / '\
        + 'specialist - name, contact details). If necessary, it is permitted that the medical '\
        + 'team of the contingent management may contact the named medical specialist in order '\
        + 'to exchange health data / information (release from confidentiality):', size: 6,
                                                                                   style: :italic
        pdf.move_down 1.mm
        text '
        ..... Kontaktdaten Arzt mit Beispieladresse und Tätigkeitsfeld Mail und Telefonummer.......

        '
        pdf.move_down 1.mm
        text 'Medikamente:', size: 12
        text 'Medications:', size: 6, style: :italic
        pdf.move_down 1.mm
        text 'Mein / Unser Kind bekommt folgende Medikamente:', size: 12
        text 'My / Our child is receiving the following medications:', size: 6, style: :italic
        text 'Dauermedikation (Dosierung / Einnahmeschema / Einnahmegrund):', size: 10
        text 'Continuous medication (dosage / intake regimen / reason for intake):', size: 6,
                                                                                     style: :italic
        pdf.move_down 1.mm
        text '
        .....Medikation .....

        '
        pdf.move_down 1.mm
        text 'Bedarfsmedikation (Dosierung / Tageshöchstmenge / Einnahmegrund):', size: 10
        text 'Needs medication (dosage / daily maximum / reason for taking):', size: 6,
                                                                               style: :italic
        pdf.move_down 1.mm
        text '
        .....Bedarfsmedikation.......

        '
        pdf.move_down 1.mm
        text 'Unser Kind nimmt die Medikamente selbst ein: ', size: 10
        text 'Our child takes the medication himself: ', size: 6, style: :italic
        pdf.move_down 1.mm
        text 'ja nein'
        pdf.move_down 1.mm
        text 'Mit dem Hausarzt ist abzuklären, ob für die bestehende Dauer- & Bedarfsmedikation'\
        + ' ein aktueller Medikamentenplan der Medikamente mitgeführt werden muss.'
        pdf.move_down 1.mm
        text 'Weiteres:', size: 12
        pdf.move_down 1.mm
        text 'Bei meinem / unserem Kind ist auf Folgendes zu Achten (Einschränkungen z.B. auf '\
        + 'Grund der Religionszugehörigkeit, etc.):', size: 10
        text 'Please pay attention to the following for my / our child (restrictions e.g. based '\
        + 'on religious affiliation, etc.): ', size: 6, style: :italic
        pdf.move_down 1.mm
        text '
        .......Achtung Ah.......

        '
        pdf.move_down 1.mm
        text 'Das ist uns noch wichtig:', size: 10
        text 'This is also important to us: ', size: 6, style: :italic
        pdf.move_down 1.mm
        text '
        ..... Ganz Wichtig .....

        '
        pdf.move_down 1.mm
        text 'Im Falle eines Falles:', size: 10
        pdf.move_down 1.mm
        text 'Im Falle einer Erkrankung oder eines Unfalles, bei denen durch eine Behandlung oder '\
        + 'vorläufige Nicht-Behandlung in der Regel keine bleibenden Schäden zu erwarten sind '\
        + '(Bagatellerkrankungen-, verletzungen, Zecke/Splitter entfernen,...) darf unser Kind '\
        + 'eigenständig über Behandlungen entscheiden und in medizinische Eingriffe einwilligen, '\
        + 'da es die für eine solche Entscheidung notwendige persönliche geistige und körperliche '\
        + 'Reife aufweist. Die Versorgung darf auch von Seiten der Betreuung erfolgen.

        Bei lebensbedrohlichen Erkrankungen / Unfällen entscheidet der behandelnde Arzt vor Ort.'

        pdf.move_down 3.mm
        text 'Wie kann man Dich in Belastungsphasen unterstützen ? (Schokolade, Musik, '\
        + 'Liebings-Song, etc):', size: 10
        pdf.move_down 1.mm
        text '
        ..... Ganz Wichtig .....
        '

        text 'Für Rückfragen stehen die Ärzte im Kontingentsteam unter '\
        + 'medizin@worldscoutjamboree.de zur Verfügung.'
        text ''
      end
      # rubocop:enable AbcSize
      # rubocop:enable MethodLength
    end
  end
end

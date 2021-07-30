# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

module Wsjrdp2023
  module Export::Pdf::Registration
    class DataAgreement < Section
      def render
        pdf.y = bounds.height - 60
        bounding_box([0, 230.mm], width: bounds.width, height: bounds.height - 200) do
          font_size(8) do
            text list, style: :italic, width: bounds.width
          end
        end
      end

      # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      def list
        pdf.start_new_page
        text 'Hinweise zur Datenverarbeitung', size: 14
        pdf.move_down 3.mm
        text 'Diese Datenschutzhinweise gelten für die Verarbeitung personenbezogener Daten der'\
        + ' Teilnehmer*innen am 25. World Jamboree 2023 durch den rdp.'
        pdf.move_down 3.mm
        text 'v0.3 vom 28.07.2021'
        pdf.move_down 3.mm

        pdf.move_down 3.mm
        text '1. Verantwortlicher der Datenverarbeitung', size: 12
        pdf.move_down 3.mm
        text '1.1 Verantwortlich für die Datenverarbeitung ist der Ringe deutscher'\
        + ' Pfadfinder*innenverbände e.V. (rdp),
            vertreten durch Joschka Hench, Sebastian'\
        + ' Köngeter, Oliver Mahn, Naima Hartit,
            Chausseestraße 128/129,
            10115 Berlin,
            Telefonnummer Büro: +49 30 288 7895 35,
            E-Mail: info@rdp-pfadfinden.de.'
        pdf.move_down 1.mm
        text '1.2 Der Datenschutzbeauftragte des rdp ist erreichbar unter'\
        + ' datenschutz@psg-aachen.de oder schriftlich unter der'\
        + ' Anschrift des Verantwortlichen mit dem Zusatz „Der Datenschutzbeauftragte“.'

        pdf.move_down 3.mm
        text '2. Erhobene Daten, Zwecke und Rechtsgrundlage der Datenverarbeitung', size: 12
        pdf.move_down 3.mm
        text '2.1 Bei der Anmeldung zur Veranstaltung erfasst der rdp über das Anmeldeformular'\
        + ' unter anmeldung.worldscoutjamboree.de personenbezogene Daten des Teilnehmers'\
        + ' und ggf. dessen/deren Personensorgeberechtigten. Diese Daten sind erforderlich'\
        + ' für die Vorbereitung und Durchführung der Veranstaltung. Ohne Offenlegung der'\
        + ' Daten sind die Anmeldung und die Teilnahme nicht möglich.'
        pdf.move_down 1.mm
        text 'Rechtsgrundlage der Verarbeitung ist die Anbahnung und Erfüllung des'\
        + ' Reisevertrages mit dem Teilnehmer, Art. 6 Abs. 1 lit. b DSGVO.'
        pdf.move_down 1.mm
        text '2.2 Soweit gesundheitsbezogene Daten des Teilnehmers erfasst werden,'\
        + ' erfolgt dies auch zum Schutz lebenswichtiger Interessen des Teilnehmers,'\
        + ' Art. 6 Abs. 1 lit. d DSGVO.'

        pdf.move_down 3.mm
        text '3. Empfänger bzw. Kategorien von Empfängern der personenbezogenen Daten', size: 12
        pdf.move_down 3.mm
        text '3.1 Einzelne Angehörige von Mitgliedsverbänden, die im Auftrag des rdp in'\
        + ' Planung, Vorbereitung und Durchführung der Veranstaltung einbezogen sind'\
        + ' (Mitglieder des Kontingentsteams im besondern Systemadministratoren, Unitbetreuer,'\
        + ' Ärzte, Tourenplaner, Logistiker, und die jeweilig verantworlichen Unitleiter*innen'\
        + ' ) erhalten je nach Inhalt ihrer Tätigkeit Zugriff'\
        + ' auf personenbezogene Daten der Teilnehmer*innen, soweit dies für die Erfüllung der'\
        + ' ihnen übertragenen Aufgaben erforderlich ist. Rechtsgrundlage ist Art. 6 Abs.'\
        + ' 1 lit. b DSGVO. Mit den Empfängern ist eine Vertraulichkeitsvereinbarung'\
        + ' abgeschlossen.'
        pdf.move_down 1.mm
        text '3.2 Einzelne personenbezogene Daten werden an Unternehmen und Organisationen'\
        + 'übertragen, deren'\
        + ' Dienste der Veranstalter in Anspruch nimmt, um seine Pflichten aus dem'\
        + ' Reisevertrag zu erfüllen (im besonderen:'\
        + ' consense travel gmbh / Solmsstraße in 60486 Frankfurt am Main,'\
        + ' Bund der Pfadfinderinnen und Pfadfinder e.V. (BdP) /'\
        + ' Kesselhaken 23 34376 Immenhausen,'\
        + ' Deutsche Pfadfinderschaft Sankt Georg /'\
        + ' Martinstraße 2 in 41472 Neuss (Holzheim),'\
        + ' Verband Christlicher Pfadfinderinnen und Pfadfinder / '\
        + ' VCP BundeszentraleWichernweg 3 in 34121 Kassel'\
        + ' ).'\
        + ' Hierzu zählen insbesondere Name, Anschrift, Geburtsdatum, Telefonnummern,'\
        + ' Emailadresse, Mitgliedsnummer und Details zu den Reisedokumenten. '\
        + ' Rechtsgrundlage ist'\
        + ' Art. 6 Abs. 1 lit. b DSGVO.'
        pdf.move_down 1.mm
        text '3.3 Einzelne personenbezogene Daten werden an den Veranstalter des'\
        + ' Jamboree (The Organizing Committee for the 25th World Scout Jamboree - '\
        + ' 2023 SaeManGeum, 301, 28 Saemunan-ro 5ga-gil, Jongno-gu, Seoul,'\
        + ' Republic of Korea) übermittelt. Dieser hat'\
        + ' seinen Sitz in der Republik Korea und damit außerhalb des Geltungsbereiches'\
        + ' der DSGVO und des BDSG. Der Veranstalter hat rechtliche und technische'\
        + ' Vorkehrungen getroffen, damit die Datensicherheit und der Datenschutz der'\
        + ' personenbezogenen Daten der Teilnehmer*innen zu jeder Zeit gewährleistet ist.'\
        + ' Nähere Auskünfte zu diesen Vorkehrungen erteilt der rdp auf Anfrage.'\
        + ' Rechtsgrundlage der Übertragung ist Art. 6 Abs. 1 lit. b DSGVO. '
        pdf.move_down 1.mm
        text '3.4 Auf die erhobenen Gesundheitsdaten haben folgende Personen Zugriff:'\
        + ' Die jeweils verantwortlichen Unitleiter und Unitbetreuer als verantwortliche'\
        + ' Aufsichtspersonen; die Ärztinnen und Ärzte, soweit im Einzelfall eine medizinische'\
        + ' Betreuung oder Behandlung des*der Teilnehmers*Teilnehmerin erforderlich wird; die'\
        + ' Systemadministratoren des Deutschen Kontingents. Rechtsgrundlage sind'\
        + ' Art. 6 Abs. 1 lit. b und d DSGVO. Mit den Empfängern'\
        + ' ist eine Vertraulichkeitsvereinbarung abgeschlossen.'
        pdf.move_down 1.mm
        text '3.5 Soweit gesundheitsbezogene Daten einzelner Teilnehmer*innen an den'\
        + ' Veranstalter des Jamboree (The Organizing'\
        + ' Committee for the 25th World Scout Jamboree - '\
        + ' 2023 SaeManGeum, 301, 28 Saemunan-ro 5ga-gil, Jongno-gu, Seoul,'\
        + ' Republic of Korea) übertragen werden, geschieht dies auf der'\
        + ' Grundlage von Art. 6 Abs. 1 lit. b und d DSGVO. '
        pdf.move_down 1.mm
        text '3.6 Bild- und Tonaufnahmen dürfen vom rdp an Dritte weitergegeben werden,'\
        + ' insbesondere an seine Mitgliedsverbände und für Zwecke der Information der'\
        + ' Öffentlichkeit und für die Außendarstellung. Rechtsgrundlage hierfür ist'\
        + ' Art. 6 Abs. 1 lit. b DSGVO.'

        pdf.move_down 3.mm
        text '4. Speicherungs- und Löschfristen', size: 12
        pdf.move_down 3.mm
        text '4.1 Die erhobenen Daten werden gespeichert, solange ihre Kenntnis für die'\
        + ' Vorbereitung, Durchführung und Nachbereitung des Jamboree erforderlich ist.'\
        + ' Nach Ablauf der gesetzlichen Aufbewahrungsfristen werden die Daten gelöscht'\
        + ' oder gesperrt.'
        pdf.move_down 1.mm
        text '4.2 Bild- und Tonaufnahmen der Teilnehmer*innen werden gelöscht, sobald sie nicht'\
        + ' mehr für Zwecke der Dokumentation der Veranstaltung oder für die'\
        + ' Außendarstellung des rdp benötigt werden.'

        pdf.move_down 3.mm
        text '5. Betroffenenrechte', size: 12
        pdf.move_down 3.mm
        text 'Betroffene haben das Recht, '
        pdf.move_down 1.mm
        text '-  gemäß Art. 15 DSGVO Auskunft über ihre vom rdp verarbeiteten personenbezogenen'\
        + ' Daten zu verlangen. Insbesondere können sie Auskunft über die Verarbeitungszwecke,'\
        + ' die Kategorie der personenbezogenen Daten, die Kategorien von Empfängern, gegenüber'\
        + ' denen ihre Daten offengelegt wurden oder werden, die geplante Speicherdauer,'\
        + ' das Bestehen eines Rechts auf Berichtigung, Löschung, Einschränkung der Verarbeitung'\
        + ' oder Widerspruch, das Bestehen eines Beschwerderechts, die Herkunft ihrer Daten,'\
        + ' sofern diese nicht bei dem rdp erhoben wurden, sowie über das Bestehen einer'\
        + ' automatisierten Entscheidungsfindung einschließlich Profiling und ggf.'\
        + ' aussagekräftigen Informationen zu deren Einzelheiten verlangen;'
        pdf.move_down 1.mm
        text '-  gemäß Art. 16 DSGVO unverzüglich die Berichtigung unrichtiger oder'\
        + ' Vervollständigung ihrer beim rdp gespeicherten personenbezogenen Daten zu verlangen;'
        pdf.move_down 1.mm
        text '-  gemäß Art. 17 DSGVO die Löschung ihrer beim rdp gespeicherten personenbezogenen'\
        + ' Daten zu verlangen, soweit sie nicht für die Zwecke der Vertragsdurchführung'\
        + ' erforderlich'\
        + ' sind oder die nicht die Verarbeitung zur Ausübung des Rechts auf freie'\
        + ' Meinungsäußerung und Information, zur Erfüllung einer rechtlichen Verpflichtung,'\
        + ' aus Gründen des öffentlichen Interesses oder zur Geltendmachung, Ausübung oder'\
        + ' Verteidigung von Rechtsansprüchen erforderlich ist;'
        pdf.move_down 1.mm
        text '-  gemäß Art. 18 DSGVO die Einschränkung der Verarbeitung ihrer personenbezogenen'\
        + ' Daten zu verlangen, soweit (1) die Richtigkeit der Daten von ihnen bestritten'\
        + ' wird, (2) die Verarbeitung unrechtmäßig ist, der Betroffene aber deren Löschung'\
        + ' ablehnt, (3) der rdp die Daten nicht mehr benötigt, der*die Teilnehmer*in  sie jedoch'\
        + ' zur Geltendmachung, Ausübung oder Verteidigung von Rechtsansprüchen benötigt'\
        + ' oder (4) der*die Teilnehmer*in gemäß Art. 21 DSGVO Widerspruch gegen die Verarbeitung'\
        + ' eingelegt hat;'
        pdf.move_down 1.mm
        text '-  gemäß Art. 20 DSGVO ihre personenbezogenen Daten, die sie dem rdp bereitgestellt'\
        + ' haben, in einem strukturierten, gängigen und maschinenlesebaren Format zu'\
        + ' erhalten oder die Übermittlung an einen anderen Verantwortlichen zu verlangen und'
        pdf.move_down 1.mm
        text '-  gemäß Art. 77 DSGVO sich bei einer Aufsichtsbehörde zu beschweren. '

        pdf.move_down 3.mm
        text 'Stand dieser Hinweise: Juli 2021.'
        text ''
      end
      # rubocop:enable Metrics/AbcSize,Metrics/MethodLength
    end

  end
end

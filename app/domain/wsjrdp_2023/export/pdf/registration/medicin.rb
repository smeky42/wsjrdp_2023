# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

module Wsjrdp2023
  module Export::Pdf::Registration
    # rubocop:disable Metrics/ClassLength
    class Medicin < Section
      def render
        pdf.y = bounds.height - 60
        bounding_box([0, 230.mm], width: bounds.width, height: bounds.height - 200) do
          font_size(8) do
            text list, style: :italic, width: bounds.width
          end
        end
      end

      # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Style/MultilineTernaryOperator,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
      def list
        of_legal_age = @person.years.to_i >= 18
        if of_legal_age
          signature = pdf.make_table([
                                       [{ content: @person.town + ' den ' \
                                        + Time.zone.today.strftime('%d.%m.%Y'), height: 30 }],
                                       ['______________________________', ''],
                                       [{ content: @person.full_name, height: 30 }, '']
                                     ],
                                     cell_style: { width: 240, padding: 1, border_width: 0,
                                                   inline_format: true })
        elsif @person.additional_contact_single
          signature = pdf.make_table([
                                       [{ content: @person.town + ' den ' \
                                         + Time.zone.today.strftime('%d.%m.%Y'), height: 30 }],
                                       %w(__________________________ __________________________),
                                       [{ content: @person.additional_contact_name_a, height: 30 },\
                                        + @person.full_name]
                                     ],
                                     cell_style: { width: 240, padding: 1, border_width: 0,
                                                   inline_format: true })
        else
          signature = pdf.make_table([
                                       [{ content: @person.town + ' den ' \
                                         + Time.zone.today.strftime('%d.%m.%Y'), height: 30 }],
                                       %w(__________________________ __________________________),
                                       [{ content: @person.additional_contact_name_a, height: 30 },\
                                        + @person.additional_contact_name_b],
                                       ['______________________________', ''],
                                       [{ content: @person.full_name, height: 30 }, '']
                                     ],
                                     cell_style: { width: 240, padding: 1, border_width: 0,
                                                   inline_format: true })
        end



        pdf.start_new_page
        text 'Was muss ich mit dem Medizinbogen machen?', size: 12
        text 'Der Medizinbogen muss'
        text '1. vollständig unterschrieben werden'
        text '2. am ersten Treffen der entsprechenden Betreuungsperson im Orginal überreicht werden'

        pdf.move_down 3.mm
        pdf.stroke_horizontal_rule
        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_header'), size: 14
        text 'zu ' + @person.full_name
        text 'Ansprechpartner im Notfall: '
        text @person.additional_contact_name_a
        text @person.additional_contact_name_b
        text 'Telefonnummern: '
        # text @person.all_phone_numbers

        phone_numbers = PhoneNumber.select([:contactable_id, :number,
                                            :label]).where(contactable_id: 2)

        phone_numbers.each do |number|
          text "#{number.label}: #{number.number}"
        end


        pdf.move_down 3.mm

        text I18n.t('activerecord.attributes.person.medicine_info')

        pdf.move_down 3.mm
        text 'Grundsätzliches', size: 12
        pdf.move_down 1.mm
        text 'Änderungen müssen bis zum Antritt der Reise unverzüglich dem Veranstalter/dem '\
        + 'ärztlichem Team über die Anmeldung (anmeldung.worldscoutjamboree.de) mitgeteilt werden.'
        pdf.move_down 1.mm
        text 'Krankenversicherungskarte und Impfausweis sind mitzuführen. Der Gesundheitsbogen '\
        + 'ist von der Unitleitung mitzuführen.'
        pdf.move_down 1.mm
        text 'Auf dem Gesundheitsbogen werden sensilbe Daten erfasst. Wir benötigen diese '\
        + 'zur Durchführung der Reise und für den Veranstalter des World Scout Jamborees.'\
        + ' Wir verfahren sehr sorgfältig mit den Daten, mehr dazu findet sich in unseren'\
        + ' Datenschutzhinweisen im Anhang.'

        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_vaccination_header'), size: 10
        text 'Vaccinations', size: 6, style: :italic
        text I18n.t('activerecord.attributes.person.medicine_vaccination_help')
        pdf.move_down 1.mm
        text I18n.t('activerecord.attributes.person.medicine_stiko_vaccination'), size: 10
        text 'My child has the vaccinations recommended by the STIKO'\
        + ' (German Advisory Board for Vaccination)', size: 6, style: :italic
        text '' + (@person.medicine_stiko_vaccination ? 'JA' : 'NEIN'), style: :italic,
                                                                        color: '0000ff'

        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_vaccination_recommendation')
        pdf.move_down 1.mm
        text 'Weitere Impfungen (Impfdatum Monat/Jahr)'
        text (@person.medicine_vaccination.empty? ?
          '--' : @person.medicine_vaccination), style: :italic,
                                                color: '0000ff'

        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_preexisting_conditions'), size: 10
        text 'Known pre-existing conditions/surgeries/childhood illnesses', size: 6, style: :italic
        pdf.move_down 1.mm
        text (@person.medicine_preexisting_conditions.empty? ?
          '--' : @person.medicine_preexisting_conditions), style: :italic,
                                                           color: '0000ff'

        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_abnormalities'), size: 10
        text I18n.t('activerecord.attributes.person.medicine_abnormalities_info')
        text 'The following abnormalities / illnesses are known (e.g. asthma, motion sickness, '\
        + 'epilepsy, anxiety disorder, AD(H)S, increased care needs, etc.)', size: 6,
                                                                             style: :italic
        pdf.move_down 1.mm
        text (@person.medicine_abnormalities.empty? ?
          '--' : @person.medicine_abnormalities), style: :italic,
                                                  color: '0000ff'

        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_allergies'), size: 10
        text I18n.t('activerecord.attributes.person.medicine_allergies_info')
        text 'The following allergies exist (e.g. to medications, proven food allergies, '\
        + 'hay fever, etc.) with the following symptoms', size: 6, style: :italic
        pdf.move_down 1.mm
        text (@person.medicine_allergies.empty? ?
          '--' : @person.medicine_allergies), style: :italic,
                                              color: '0000ff'

        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_eating_disorders'), size: 10
        text 'The following eating disorders with the following symptoms '\
        + 'exist', size: 6, style: :italic
        pdf.move_down 1.mm
        text (@person.medicine_eating_disorders.empty? ?
          '--' : @person.medicine_eating_disorders), style: :italic,
                                                     color: '0000ff'

        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_mobility_needs'), size: 10
        text 'There are the following mobility needs due to '\
        + 'exist', size: 6, style: :italic
        pdf.move_down 1.mm
        text (@person.medicine_mobility_needs.empty? ?
          '--' : @person.medicine_mobility_needs), style: :italic,
                                                   color: '0000ff'
        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_infectious_diseases'), size: 10
        text 'There is currently an infectious disease, if so which one', size: 6, style: :italic
        pdf.move_down 1.mm
        text (@person.medicine_infectious_diseases.empty? ?
          '--' : @person.medicine_infectious_diseases), style: :italic,
                                                        color: '0000ff'

        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_medical_treatment_contact'), size: 10
        text I18n.t('activerecord.attributes.person.medicine_medical_treatment_contact_info')
        text I18n.t('activerecord.attributes.person.medicine_medical_treatment_contact_help')
        text 'My / Our child is currently undergoing medical treatment (attending physician / '\
        + 'specialist - name, contact details). If necessary, it is permitted that the medical '\
        + 'team of the contingent management may contact the named medical specialist in order '\
        + 'to exchange health data / information (release from confidentiality)', size: 6,
                                                                                  style: :italic
        pdf.move_down 1.mm
        text (@person.medicine_medical_treatment_contact.empty? ?
          '--' : @person.medicine_medical_treatment_contact), style: :italic,
                                                              color: '0000ff'

        pdf.move_down 3.mm
        text 'Medikamente', size: 12
        text 'Medications', size: 6, style: :italic
        pdf.move_down 1.mm
        text 'Mein / Unser Kind bekommt folgende Medikamente', size: 12
        text 'My / Our child is receiving the following medications', size: 6, style: :italic
        text I18n.t('activerecord.attributes.person.medicine_continous_medication'), size: 10
        text I18n.t('activerecord.attributes.person.medicine_continous_medication_info')
        text 'Continuous medication (dosage / intake regimen / reason for intake)', size: 6,
                                                                                    style: :italic
        pdf.move_down 1.mm
        text (@person.medicine_continous_medication.empty? ?
          '--' : @person.medicine_continous_medication), style: :italic,
                                                         color: '0000ff'

        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_needs_medication'), size: 10
        text I18n.t('activerecord.attributes.person.medicine_needs_medication_info')
        text 'Needs medication (dosage / daily maximum / reason for taking)', size: 6,
                                                                              style: :italic
        pdf.move_down 1.mm
        text (@person.medicine_needs_medication.empty? ?
          '--' : @person.medicine_needs_medication), style: :italic,
                                                     color: '0000ff'

        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_medications_self_treatment'), size: 10
        text 'Our child takes the medication himself: ', size: 6, style: :italic
        pdf.move_down 1.mm
        text '' + (@person.medicine_medications_self_treatment ? 'JA' : 'NEIN'), style: :italic,
                                                                                 color: '0000ff'

        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_medication_help')


        pdf.move_down 3.mm
        text 'Weiteres', size: 12
        pdf.move_down 1.mm
        text I18n.t('activerecord.attributes.person.medicine_other'), size: 10
        text 'Please pay attention to the following for my / our child (restrictions'\
        + ' etc.): ', size: 6, style: :italic
        pdf.move_down 1.mm
        text (@person.medicine_other.empty? ? '--' : @person.medicine_other), style: :italic,
                                                                              color: '0000ff'

        pdf.move_down 3.mm
        # text I18n.t('activerecord.attributes.person.medicine_important'), size: 10
        # text 'This is also important to us: ', size: 6, style: :italic
        # pdf.move_down 1.mm
        # text (@person.medicine_important.empty? ?
        #   '--' : @person.medicine_important), style: :italic,
        #                                       color: '0000ff'

        # pdf.move_down 3.mm
        text 'Im Falle eines Falles', size: 10
        pdf.move_down 1.mm
        text I18n.t('activerecord.attributes.person.medicine_case')
        pdf.move_down 1.mm
        text I18n.t('activerecord.attributes.person.medicine_case_doctor')

        pdf.move_down 3.mm
        text I18n.t('activerecord.attributes.person.medicine_support'), size: 10
        pdf.move_down 1.mm
        text (@person.medicine_support.empty? ? '--' : @person.medicine_support), style: :italic,
                                                                                  color: '0000ff'


        pdf.move_down 5.mm
        text '' + (of_legal_age ? 'Ich habe' : 'Wir haben') + ' den Gesundheitsfragebogen '\
        + 'warheitsgemäß ausgefüllt.'
        pdf.move_down 1.mm
        text '' + (of_legal_age ? 'Ich bin' : 'Wir sind') + ' damit einverstanden, dass die '\
        + 'persönlichen Daten und so wie Behandlungsdaten zum Zwecke der gesetzlich '\
        + 'vorgeschriebenen Dokumentation gespeichert werden. Nach Ablauf der gesetzlichen '\
        + 'Aufbewahrungsfrist werden die Daten gelöscht.'
        pdf.move_down 3.mm
        signature.draw
        pdf.move_down 3.mm




        text 'Für Rückfragen stehen die Ärzte im Kontingentsteam unter '\
        + 'medizin-info@worldscoutjamboree.de zur Verfügung.'
        text ''
      end
    end
    # rubocop:enable Metrics/AbcSize,Metrics/MethodLength,Style/MultilineTernaryOperator,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
  end
  # rubocop:enable Metrics/ClassLength
end

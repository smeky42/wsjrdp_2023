# Hitobito wsjrdp2023

This hitobito wagon defines the organization hierarchy with groups and roles
of the [German Contingent for the Worldscoutjamboree 2023](https://worldscoutjamboree.de) in Korea.

## Organization Hierarchy
* Kontingentsteam
  * Kontingentsteam
    * Admin: [:layer_and_below_full, :admin]
    * Kontingentsleitung: [:layer_and_below_full]
    * Kontingentsteam: []
    * KT Unassigned: []
* IST
  * IST
    * Head IST: [:group_other_roles_and_below_full]
    * IST: []
    * IST Unassigned: []
* Unit Betreuung
  * Unit Betreuung
    * Head Unitbetreuung: [:layer_and_below_full]
    * Unitbetreuung: [:group_other_roles_and_below_full]
* Unit
  * Unit
    * Unitleitung: [:group_other_roles_and_below_full]
    * Teilnehmende: []
    * UL Unassigned: []
    * TN Unassigned: []

(Output of rake app:hitobito:roles)

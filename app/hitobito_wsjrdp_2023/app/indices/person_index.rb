#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.


module PersonIndex; 

ThinkingSphinx::Index.define_partial :person do
  indexes :rdp_association, 
        :rdp_association_region, 
        :rdp_association_sub_region, 
        :rdp_association_group, 
        :rdp_association_number
end
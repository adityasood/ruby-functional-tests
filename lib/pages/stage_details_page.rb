##########################################################################
# Copyright 2018 ThoughtWorks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################################################################

module Pages
  class StageDetailsPage < AppBase
    set_url "#{GoConstants::GO_SERVER_BASE_URL}/pipelines{/pipeline_name}{/label}{/stage_name}{/counter}{/tab_name}"

    element :build_cause_box, ".build_cause"
    elements :materials, ".material"
    elements :material_names, ".material_name"

    load_validation { has_css?('.page_name', text: "Stage Details")}

    def verify_latest_revision_for_modification(modification_number)
      latest_revision = Context::GitMaterials.new(basic_configuration.material_url_for(scenario_state.self_pipeline)).latest_revision
      latest_revision == getRevisionForModification(modification_number)
    end

    def verify_revision_for_modification(modification_number, expected_revision)
      getRevisionForModification(modification_number) == expected_revision
    end

    def verify_material_has_changed(material_type, material_name)
      material_section = material_header_for(material_type, material_name).first(:xpath, ".//..")
      material_section[:class].include?("changed")
    end

    def verify_comment_in_modification(modification_number, comment)
      modification = modification_section_for(modification_number)
      modification.find('.comment').text.include?(comment)
    end

    def verify_modification_triggered_by(modification_number, user_name)
      modification = modification_section_for(modification_number)
      modified_by_text = modification.find('.modified_by').text
      commit_author = modified_by_text.split('on')[0]
      commit_author.include?(user_name)
    end

    private
    def getRevisionForModification(modification_number)
      modification = modification_section_for(modification_number)
      modification.find('.revision dl dd').text
    end

    def modification_section_for(modification_number)
      material_header = material_header_for(scenario_state.get_current_material_type, scenario_state.get_current_material_name)
      material_header.first(:xpath, ".//..").all('.change')[modification_number.to_i]
    end

    def material_header_for(material_type, material_name)
      material_names.select {|name| name.text.include? "#{material_type} - #{material_name}"}.first
    end

  end
end

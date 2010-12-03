module ProjectsHelper
  def max(project)
    project.builds.size <= 4 ? project.builds.size : 4
  end

  def build_status(build)
    if build.built?
      if build.passed?
        link_to image_tag('tiny_ferrari.jpg'), "#{build.project.name}/builds/#{build.id}"
      else
        link_to image_tag('tiny_cuffs.jpg'), "#{build.project.name}/builds/#{build.id}"
      end
    else
      link_to image_tag('tiny_heli.gif'), "#{build.project.name}/builds/#{build.id}"
    end
  end
end

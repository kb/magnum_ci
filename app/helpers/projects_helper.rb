module ProjectsHelper
  def last_build_state(project)
    if project.builds.empty?
      return 'ferrari.jpg'
    end
    if project.builds.last.built?
      if project.builds.last.passed?
        return 'ferrari.jpg'
      else
        return 'cuffs.jpg'
      end
    else
      return 'heli.jpg'
    end
  end
end

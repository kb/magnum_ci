module ProjectsHelper
  def build_statuses(project)
    result = ""
    max = project.builds.size < 5 ? project.builds.size : 5
    project.builds.reverse[0..max].each do |build|
      if build.built?
        if build.passed?
          result += "<a href=/#{project.name}/builds/#{build.id}><img src='/images/tiny_ferrari.jpg' alt='Tiny_ferrari'></a>"
        else
          result += "<a href=/#{project.name}/builds/#{build.id}><img src='/images/tiny_cuffs.jpg' alt='Tiny_cuffs'></a>"
        end
      else
        result += "<a href=/#{project.name}/builds/#{build.id}><img src='/images/tiny_heli.jpg' alt='Tiny_heli'></a>"
      end
    end
    result
  end
end

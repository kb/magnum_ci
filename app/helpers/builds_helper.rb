module BuildsHelper
  def build_state(build)
    if build.built?
      if build.passed?
        return 'ferrari.jpg'
      else
        return 'cuffs.jpg'
      end
    else
      return 'heli.jpg'
    end
  end
end

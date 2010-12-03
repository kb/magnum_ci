module BuildsHelper
  def build_state(build)
    if build.built?
      if build.passed?
        return 'ferrari.jpg'
      else
        return 'cuffs.jpg'
      end
    else
      return 'heli.gif'
    end
  end

  def pretty_print_log(log)
    return unless log
    raw(log.gsub("\e[0m", '</span>').
            gsub("\e[31m", '<span class="color31">').
            gsub("\e[32m", '<span class="color32">').
            gsub("\e[33m", '<span class="color33">').
            gsub("\e[34m", '<span class="color34">').
            gsub("\e[35m", '<span class="color35">').
            gsub("\e[36m", '<span class="color36">').
            gsub("\e[37m", '<span class="color37">').
            gsub(/\n/, '<br>'))
  end
end

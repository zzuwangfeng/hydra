local function normalize(str)
  if str == 'v1.0.b99' then -- yeah, i messed up
    return '00.00'
  else
    return str:gsub("(%d+)", function(n) return ("%02d"):format(n) end)
  end
end

--- hydra.updates.check(fn(isavailable))
--- Checks for an update. Calls the given function with a boolean representing whether a new update is available.
function hydra.updates.check(fn)
  hydra.updates.getversions(function(versions)
      table.sort(versions, function(a, b) return normalize(a.number) < normalize(b.number) end)
      local hasupdate = normalize(versions[#versions].number) > normalize(hydra.updates.currentversion())
      fn(hasupdate)
  end)
end

--- hydra.updates.install()
--- Currently just opens the page containing the update; in the future, this will actually install the update and restart Hydra.
function hydra.updates.install()
  os.execute("open https://github.com/sdegutis/hydra/releases")
end

--- hydra.updates.changelogurl
--- String of the URL that contains the changelog, rendered via Markdown
hydra.updates.changelogurl = "https://github.com/sdegutis/hydra/releases"

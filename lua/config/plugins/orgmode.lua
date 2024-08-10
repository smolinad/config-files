
return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    require('orgmode').setup({
      org_agenda_files = {'~/orgfiles/**/*', "G:\\My Drive\\orgfiles"},
      org_default_notes_file = '~/orgfiles/refile.org',
    })
  end
}

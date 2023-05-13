require('harpoon').setup({
  projects = {
   ['~/personal/7db-crawler'] = {
     term = {
       cmds = {
         'clear && yarn test\n',
       },
     },
   },
   ['~/personal/apdexone/apdexone-demo/backend'] = {
     term = {
       cmds = {
         'clear && yarn test\n',
         'clear && yarn build && yarn dev\n',
       },
     },
   },
   ['~/personal/apdexone/apdexone-demo/frontend'] = {
     term = {
       cmds = {
         'clear && yarn jest\n',
         'clear && yarn serve\n',
       },
     },
   },
  },
})

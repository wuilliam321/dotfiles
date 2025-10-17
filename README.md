# dotfiles

```
stow -S .
```

```
stow -R .
```

select * from vendor;
\d
\d entity;
\d entity_step;
\d entity_step_required_state;
\d entity_step_state;
\d schema_migrations;
\d state;
\d step;
\d user_training;
\d user_training_entity_step;
\d user_training_step;
\d vendor;
\d vendor_step;
\d vendor_step_state;


\d vendor_onboarding;

select
  *
from
  vendor_onboarding
where
  global_entity_id = 'PY_UY'
  and vendor_id = '44688'
  -- and activated_at is not null
order by
  vendor_id asc
;


update
  vendor_onboarding
set
  activated_at = '2022-06-28 08:32:23.350216+00'
where
  global_entity_id = 'PY_UY'
  and vendor_id = '44688'

## Keyboard
put 'dvorak_custom' file in this location /usr/share/X11/xkb/symbols/dvorak_custom
add this: 'English (Dvorak, Custom)' => 'dvorak_custom', to
`/usr/share/console-setup/KeyboardNames.pl` in an english language

in: `/etc/default/keyboard` add these lines:

```
XKBMODEL="kinesis"
XKBLAYOUT="us"
XKBVARIANT="dvorak_custom"
XKBOPTIONS="lv3:menu_switch,compose:rctrl,terminate:ctrl_alt_bksp"

BACKSPACE="guess"
```

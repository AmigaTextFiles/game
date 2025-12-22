#ifndef GS_ANIMREGPROTO
#define GS_ANIMREGPROTO

int __asm _gs_blit_get_save_area(register __a0 struct blit_struct *);
void __asm _gs_blit_free_save_area(register __a0 struct blit_struct *);
void __asm _gs_blit_image(register __a0 struct blit_struct *,
  register __a1 struct BitMap *,register __d0 int,register __d1 int);
void __asm _gs_blit_image_fine(register __a0 struct blit_struct *,
  register __a1 struct BitMap *,register __d0 int,register __d1 int,
  register __d2 int,register __d3 int,register __d4 int);
void __asm _gs_blit_image2(register __a0 struct blit_struct *,
  register __a1 struct BitMap *);
void __asm _gs_blit_copy2(register __a0 struct blit_struct *,
  register __a1 struct BitMap *);
void __asm _gs_blit_save_bg(register __a0 struct blit_struct *,
  register __a1 struct BitMap *,register __d0 int,register __d1 int);
void __asm _gs_blit_restore(register __a0 struct blit_struct *,
  register __a1 struct BitMap *);
void __asm _gs_blit_clear(register __a0 struct blit_struct *,
  register __a1 struct BitMap *,register __d0 int,register __d1 int);
void __asm _gs_blit_copy(register __a0 struct blit_struct *,
  register __a1 struct BitMap *,register __d0 int,register __d1 int);
void __asm _gs_blit_copy_fine(register __a0 struct blit_struct *,
  register __a1 struct BitMap *,register __d0 int,register __d1 int,
  register __d2 int,register __d3 int,register __d4 int);
void __asm _gs_blit_memcopy(register __a0 void *,register __a1 void *,
  register __d0 int);

/* -------------------------------------------------------------------- */

int __asm _gs_get_display_list(void);
void __asm _gs_free_display_list(register __d0 int);
void __asm _gs_init_anim(register __d0 int, register __a0 struct BitMap *,
  register __a1 struct BitMap *);
void __asm _gs_next_anim_page(register __d0 int);
void __asm _gs_sort_anims(register __d0 int);
void __asm _gs_draw_anims(register __d0 int);
void __asm _gs_restore_anim_bg(register __d0 int);
void __asm _gs_draw_anim_objs(register __d0 int);
int __asm _gs_get_parent_save_area(register __a0 struct anim_struct *,
  register __d0 int);
int __asm _gs_get_anim_save_area(register __a0 struct anim_struct *,
  register __d0 int);
void __asm _gs_free_parent_save_area(register __a0 struct anim_struct *);
void __asm _gs_free_anim_save_area(register __a0 struct anim_struct *);
int __asm _gs_add_parent(register __d0 int, register __a0 struct anim_struct *,
 register __d1 int,register __d2 int);
int __asm _gs_add_anim(register __d0 int, register __a0 struct anim_struct *,
  register __d1 int,register __d2 int);
void __asm _gs_reverse_anim(register __a0 struct anim_struct *);
void __asm _gs_anim_forward(register __a0 struct anim_struct *);
void __asm _gs_anim_backward(register __a0 struct anim_struct *);
void __asm _gs_remove_anim(register __a0 struct anim_struct *);
void __asm _gs_clear_anim(register __a0 struct anim_struct *);
void __asm _gs_enable_anim(register __a0 struct anim_struct *);
void __asm _gs_set_anim_flicker(register __a0 struct anim_struct *);
void __asm _gs_clear_anim_flicker(register __a0 struct anim_struct *);
void __asm _gs_set_anim_merge(register __a0 struct anim_struct *);
void __asm _gs_clear_anim_merge(register __a0 struct anim_struct *);
void __asm _gs_enable_anim_collision(register __a0 struct anim_struct *);
void __asm _gs_disable_anim_collision(register __a0 struct anim_struct *);
void __asm _gs_enable_anim_collision_bg(register __a0 struct anim_struct *);
void __asm _gs_disable_anim_collision_bg(register __a0 struct anim_struct *);
void __asm _gs_set_anim_cell(register __a0 struct anim_struct *,
  register __d0 int);
void __asm _gs_move_anim(register __a0 struct anim_struct *,
  register __d0 int,register __d1 int);
void __asm _gs_anim_parent(register __a0 struct anim_struct *,
  register __d0 int,register __d1 int);
void __asm _gs_anim_children(register __a0 struct anim_struct *,
  register __d0 int,register __d1 int);
void __asm _gs_anim_obj(register __a0 struct anim_struct *,
  register __d0 int,register __d1 int);
void __asm _gs_set_collision(register __d0 int, register __a0 void *);
void __asm _gs_set_collision_bg(register __d0 int, register __a0 void *);
void __asm _gs_clear_collision(register __d0 int);
void __asm _gs_clear_collision_bg(register __d0 int);
void __asm _gs_disable_anim_bounds(register __d0 int);
void __asm _gs_enable_anim_bounds(register __d0 int);

int __asm _gs_add_anim_cplx(register __d0 int, register __a0 struct anim_cplx *,
  register __d0 int,register __d1 int,register __d2 int,register __d3 int);
int __asm _gs_get_cplx_save_area(register __a0 struct anim_cplx *,
  register __d0 int);
int __asm _gs_free_cplx_save_area(register __a0 struct anim_cplx *);
void __asm _gs_set_cplx_prio(register __a0 struct anim_cplx *,
  register __d0 int);
int __asm _gs_set_cplx_seq(register __a0 struct anim_cplx *,register __d0 int,
  register __d1 int,register __d2 int);
void __asm _gs_remove_cplx(register __a0 struct anim_cplx *);
void __asm _gs_set_cplx_flicker(register __a0 struct anim_cplx *);
void __asm _gs_clear_cplx_flicker(register __a0 struct anim_cplx *);
void __asm _gs_set_cplx_merge(register __a0 struct anim_cplx *);
void __asm _gs_clear_cplx_merge(register __a0 struct anim_cplx *);
void __asm _gs_enable_cplx_collision(register __a0 struct anim_cplx *);
void __asm _gs_disable_cplx_collision(register __a0 struct anim_cplx *);
void __asm _gs_enable_cplx_collision_bg(register __a0 struct anim_cplx *);
void __asm _gs_disable_cplx_collision_bg(register __a0 struct anim_cplx *);
void __asm _gs_clear_cplx(register __a0 struct anim_cplx *);
void __asm _gs_enable_cplx(register __a0 struct anim_cplx *);
void __asm _gs_reverse_cplx(register __a0 struct anim_cplx *);
void __asm _gs_cplx_forward(register __a0 struct anim_cplx *);
void __asm _gs_cplx_backward(register __a0 struct anim_cplx *);
void __asm _gs_set_cplx_cell(register __a0 struct anim_cplx *,
  register __d0 int);
void __asm _gs_move_cplx(register __a0 struct anim_cplx *,register __d0 int,
  register __d1 int);
void __asm _gs_anim_cplx(register __a0 struct anim_cplx *,register __d0 int,
  register __d1 int);
void __asm _gs_anim_cplx_parent(register __a0 struct anim_cplx *,
  register __d0 int,register __d1 int);
void __asm _gs_anim_cplx_children(register __a0 struct anim_cplx *,
  register __d0 int,register __d1 int);

void __asm _gs_set_anim_bounds(register __d0 int, register __d1 int,register __d2 int,
  register __d3 int,register __d4 int);
void __asm _gs_rs_offset(register __d0 int, register __d1 int, register __d2 int);
int __asm _gs_rs_dim(register __d0 int, register __d1 int, register __d2 int);
void __asm _gs_rs_window(register __d0 int, register __d1 int, register __d2 int);

#endif

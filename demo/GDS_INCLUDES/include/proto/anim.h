#ifndef GS_ANIMPROTO
#define GS_ANIMPROTO

int gs_blit_get_save_area(struct blit_struct *);
void gs_blit_free_save_area(struct blit_struct *);
void gs_blit_image(struct blit_struct *, struct BitMap *,int,int);
void gs_blit_image_fine(struct blit_struct *, struct BitMap *,int,int,int,int,int);
void gs_blit_image2(struct blit_struct *, struct BitMap *);
void gs_blit_copy2(struct blit_struct *, struct BitMap *);
void gs_blit_save_bg(struct blit_struct *, struct BitMap *,int,int);
void gs_blit_restore(struct blit_struct *, struct BitMap *);
void gs_blit_clear(struct blit_struct *, struct BitMap *,int,int);
void gs_blit_copy(struct blit_struct *, struct BitMap *,int,int);
void gs_blit_copy_fine(struct blit_struct *, struct BitMap *,int,int,int,int,int);
void gs_blit_memcopy(void *, void *, int);
void gs_get_blitter(void);
void gs_free_blitter(void);

/* -------------------------------------------------------------------- */

int gs_load_anim(struct anim_load_struct *);
void gs_free_anim(struct anim_struct *,int);
void gs_free_cplx(struct anim_cplx *,int);

int gs_get_display_list(void);
void gs_free_display_list(unsigned long);
void gs_init_anim(int,struct BitMap *, struct BitMap *);
int gs_next_anim_page(int);
int gs_get_parent_save_area(struct anim_struct *,int);
int gs_get_anim_save_area(struct anim_struct *,int);
void gs_free_parent_save_area(struct anim_struct *);
void gs_free_anim_save_area(struct anim_struct *);
int gs_add_parent(int,struct anim_struct *,int,int);
int gs_add_anim(int,struct anim_struct *,int,int);
void gs_reverse_anim(struct anim_struct *);
void gs_anim_forward(struct anim_struct *);
void gs_anim_backward(struct anim_struct *);
void gs_remove_anim(struct anim_struct *);
void gs_clear_anim(struct anim_struct *);
void gs_enable_anim(struct anim_struct *);
void gs_set_anim_flicker(struct anim_struct *);
void gs_clear_anim_flicker(struct anim_struct *);
void gs_set_anim_merge(struct anim_struct *);
void gs_clear_anim_merge(struct anim_struct *);
void gs_enable_anim_collision(struct anim_struct *);
void gs_disable_anim_collision(struct anim_struct *);
void gs_enable_anim_collision_bg(struct anim_struct *);
void gs_disable_anim_collision_bg(struct anim_struct *);
void gs_set_anim_cell(struct anim_struct *,int);
void gs_sort_anims(int);
void gs_move_anim(struct anim_struct *,int,int);
void gs_anim_parent(struct anim_struct *,int,int);
void gs_anim_children(struct anim_struct *,int,int);
void gs_anim_obj(struct anim_struct *,int,int);
void gs_draw_anims(int);
void gs_restore_anim_bg(int);
void gs_draw_anim_objs(int);
void gs_set_collision(int,void *);
void gs_clear_collision(int);
void gs_set_collision_bg(int,void *);
void gs_clear_collision_bg(int);
void gs_disable_anim_bounds(int);
void gs_enable_anim_bounds(int);

int gs_add_anim_cplx(int,struct anim_cplx *,int,int,int,int);
int gs_get_cplx_save_area(struct anim_cplx *,int);
int gs_free_cplx_save_area(struct anim_cplx *);
void gs_set_cplx_prio(struct anim_cplx *,int);
int gs_set_cplx_seq(struct anim_cplx *,int,int,int);
void gs_remove_cplx(struct anim_cplx *);
void gs_set_cplx_flicker(struct anim_cplx *);
void gs_clear_cplx_flicker(struct anim_cplx *);
void gs_set_cplx_merge(struct anim_cplx *);
void gs_clear_cplx_merge(struct anim_cplx *);
void gs_enable_cplx_collision(struct anim_cplx *);
void gs_disable_cplx_collision(struct anim_cplx *);
void gs_enable_cplx_collision_bg(struct anim_cplx *);
void gs_disable_cplx_collision_bg(struct anim_cplx *);
void gs_clear_cplx(struct anim_cplx *);
void gs_enable_cplx(struct anim_cplx *);
void gs_reverse_cplx(struct anim_cplx *);
void gs_cplx_forward(struct anim_cplx *);
void gs_cplx_backward(struct anim_cplx *);
void gs_set_cplx_cell(struct anim_cplx *,int);
void gs_move_cplx(struct anim_cplx *,int,int);
void gs_anim_cplx(struct anim_cplx *,int,int);
void gs_anim_cplx_parent(struct anim_cplx *,int,int);
void gs_anim_cplx_children(struct anim_cplx *,int,int);

void gs_set_anim_bounds(int,int,int,int,int);
void gs_rs_offset(int,int,int);
int gs_rs_dim(int,int,int);
void gs_rs_window(int,int,int);

#endif

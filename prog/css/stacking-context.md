# Stacking Contexts

There is a great article about Stacked Contexts on [MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Positioning/Understanding_z_index/The_stacking_context)

## The Basic Idea

- Certain CSS attributes create Stacked Contexts.
- The z-index attribute only takes effect within a Stacked Context
- Outside of the Stacked Context:
  - The elements are rendered using the z-index values of this context (ignoring the deeper nested one)
  - If there are no z-index values: The elements are rendered in the order of their appearance
